//using Firebase.Analytics;
using GoogleMobileAds.Api;
using GoogleMobileAds.Common;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

public class GoogleAdMobManager : MonoBehaviour
{
    #region UNITY Variables

    //========== Ad Calling =============
    private BannerView bannerView, rectBannerView, rightBannerView;
    private InterstitialAd interstitialAd;
    public RewardedAd rewardedAd;
    private RewardedInterstitialAd rewardedInterstitialAd;

    private int bannerAdIndex = 0;
    private int squareBannerAdIndex = 0;
    private int interstitialAdIndex = 0;
    private int rewardedAdIndex = 0;
    private int RightAdmobBannerId = 0;
    private int AppOpenIndex = 0;

    public UnityEvent OnAdLoadedEvent;
    public UnityEvent OnAdFailedToLoadEvent;
    public UnityEvent OnAdOpeningEvent;
    public UnityEvent OnAdFailedToShowEvent;
    public UnityEvent OnUserEarnedRewardEvent;
    public UnityEvent OnAdClosedEvent;




    #endregion

    #region UNITY MONOBEHAVIOR METHODS


    public void Start()
    {
        MobileAds.SetiOSAppPauseOnBackground(true);

        List<String> deviceIds = new List<String>() { AdRequest.TestDeviceSimulator };


        // Add some test device IDs (replace with your own device IDs).
        #if UNITY_IPHONE
                deviceIds.Add("96e23e80653bb28980d3f40beb58915c");
        #elif UNITY_ANDROID
            deviceIds.Add("75EF8D155528C04DACBBA6F36F433035");
            deviceIds.Add("f5efc7c3-1677-4c1d-8557-c3d5ad5d6898");
            deviceIds.Add("f5efc7c316774c1d8557c3d5ad5d6898");
            deviceIds.Add("78612386D15FC0CB0E10CDE1DBAA0150");
            deviceIds.Add("a3799a04-0018-4360-9c10-679d5adb79e7");
            deviceIds.Add("a3799a04001843609c10679d5adb79e7");
            deviceIds.Add("903D93C064F5D393AC6CA51219A09CB7");
        #endif

        // Configure TagForChildDirectedTreatment and test device IDs.
        RequestConfiguration requestConfiguration;
        // Configure TagForChildDirectedTreatment and test device IDs.
         requestConfiguration = new RequestConfiguration
        {
            TagForChildDirectedTreatment = TagForChildDirectedTreatment.True,
            TestDeviceIds = deviceIds
        };

        MobileAds.SetRequestConfiguration(requestConfiguration);

        // Initialize the Google Mobile Ads SDK.
        MobileAds.Initialize((InitializationStatus initStatus) =>
        {

            if (RemoteConfigManager.instance.TopRightSmallBannerAdmob)
            {
                RequestRightBannerAd();
            }
            if (RemoteConfigManager.instance.BannerCheckAllApplovinAndAdmob)
                RequestBannerAd();
            RequestAndLoadRewardedAd();
            if (RemoteConfigManager.instance.interstitialCheck)
                RequestAndLoadInterstitialAd();
            if (RemoteConfigManager.instance.SquareBannerCheck)
                RequestRectangleAd();
            if (RemoteConfigManager.instance.EnableAppOpenAD)
                  LoadAppOpenAd();
        });


    }



    IEnumerator wait()
    {

        yield return new WaitForSeconds(1f);


        yield return new WaitForSeconds(1f);
        //
    }

    #endregion

    #region HELPER METHODS

    private AdRequest CreateAdRequest()
    {
        return new AdRequest();
    }

    #endregion

    #region BANNER ADS

    private void RequestBannerAd()
    {

        PrintStatus("Requesting Banner ad.");

        // These ad units are configured to always serve test ads.
#if UNITY_EDITOR
        string adUnitId = "unused";
#elif UNITY_ANDROID
        string adUnitId = AdManager.instance.AdmobBannerId[bannerAdIndex];
#elif UNITY_IPHONE
        string adUnitId = AdManager.instance.AdmobBannerId[bannerAdIndex];
#else
        string adUnitId = "unexpected_platform";
#endif

        // Clean up banner before reusing
        if (bannerView != null)
        {
            bannerView.Destroy();
            bannerView = null;
        }

        // Create a 320x50 banner at top of the screen
        AdSize adSize;
        if (RemoteConfigManager.instance.SimpleBanner && !RemoteConfigManager.instance.SmartBanner)
        {
            adSize = AdSize.Banner;
        }
        else if (RemoteConfigManager.instance.SmartBanner && !RemoteConfigManager.instance.SimpleBanner)
        {
            adSize = AdSize.SmartBanner;
        }
        else // Handle other cases or defaults
        {
            adSize = AdSize.Banner; // Default to a regular banner size
        }



        bannerView = new BannerView(adUnitId, adSize, AdPosition.Top);
        AdRequest adRequest = new AdRequest();
        bannerView.LoadAd(adRequest);

        bannerView.OnBannerAdLoaded += () =>
        {
            Debug.Log("Banner view loaded an ad with response : "
                + bannerView.GetResponseInfo());

            // Inform the UI that the ad is ready.

        };
        // Raised when an ad fails to load into the banner view.
        bannerView.OnBannerAdLoadFailed += (LoadAdError error) =>
        {
            Debug.LogError("Banner view failed to load an ad with error : " + error);
            if (bannerAdIndex < 2 && AdManager.instance.isThreeId)
            {
                StartCoroutine(BannerRequestDelay());
            }
        };
        // Raised when the ad is estimated to have earned money.
        bannerView.OnAdPaid += (AdValue adValue) =>
        {
            Debug.Log(String.Format("Banner view paid {0} {1}.",
                adValue.Value,
                adValue.CurrencyCode));
        };
        // Raised when an impression is recorded for an ad.
        bannerView.OnAdImpressionRecorded += () =>
        {
            Debug.Log("Banner view recorded an impression.");
        };
        // Raised when a click is recorded for an ad.
        bannerView.OnAdClicked += () =>
        {
            Debug.Log("Banner view was clicked.");
        };
        // Raised when an ad opened full screen content.
        bannerView.OnAdFullScreenContentOpened += () =>
        {
            Debug.Log("Banner view full screen content opened.");
        };
        // Raised when the ad closed full screen content.
        bannerView.OnAdFullScreenContentClosed += () =>
        {
            Debug.Log("Banner view full screen content closed.");
        };
        // Load a banner ad
        //bannerView.LoadAd(CreateAdRequest());
        if (bannerView != null)
        {
            bannerView.Hide();
        }
    }

    private IEnumerator BannerRequestDelay()
    {
        yield return new WaitForSeconds(0.1f);
        bannerAdIndex++;
        RequestBannerAd();
    }

    private void RequestRectangleAd()
    {
        PrintStatus("Requesting Square Banner ad.");
        // These ad units are configured to always serve test ads.
#if UNITY_EDITOR
        string adUnitId = "unused";
#elif UNITY_ANDROID
        string adUnitId = AdManager.instance.AdmobSquareBannerId[squareBannerAdIndex];
#elif UNITY_IPHONE
        string adUnitId = AdManager.instance.AdmobSquareBannerId[squareBannerAdIndex];
#else
        string adUnitId = "unexpected_platform";
#endif

        // Clean up banner before reusing
        if (rectBannerView != null)
        {
            rectBannerView.Destroy();
            rectBannerView = null;
        }

        rectBannerView = new BannerView(adUnitId, AdSize.MediumRectangle, AdPosition.BottomLeft);
        AdRequest adRequest = new AdRequest();
        rectBannerView.LoadAd(adRequest);

        rectBannerView.OnBannerAdLoaded += () =>
        {
            Debug.Log("Banner view loaded an ad with response : "
                + rectBannerView.GetResponseInfo());


        };
        // Raised when an ad fails to load into the banner view.
        rectBannerView.OnBannerAdLoadFailed += error =>
        {
            Debug.LogError("Banner view failed to load an ad with error : " + error);
            if (squareBannerAdIndex < 2 && AdManager.instance.isThreeId)
            {
                StartCoroutine(SquareBannerRequestDelay());
            }
        };
        // Raised when the ad is estimated to have earned money.
        rectBannerView.OnAdPaid += (AdValue adValue) =>
        {
            Debug.Log(String.Format("Banner view paid {0} {1}.",
                adValue.Value,
                adValue.CurrencyCode));
        };
        // Raised when an impression is recorded for an ad.
        rectBannerView.OnAdImpressionRecorded += () =>
        {
            Debug.Log("Banner view recorded an impression.");
        };
        // Raised when a click is recorded for an ad.
        rectBannerView.OnAdClicked += () =>
        {
            Debug.Log("Banner view was clicked.");
        };
        // Raised when an ad opened full screen content.
        rectBannerView.OnAdFullScreenContentOpened += () =>
        {
            Debug.Log("Banner view full screen content opened.");
        };
        // Raised when the ad closed full screen content.
        rectBannerView.OnAdFullScreenContentClosed += () =>
        {
            Debug.Log("Banner view full screen content closed.");
        };
        //rectBannerView.LoadAd(CreateAdRequest());
        if (rectBannerView != null)
        {
            rectBannerView.Hide();
        }
    }
    private IEnumerator SquareBannerRequestDelay()
    {
        yield return new WaitForSeconds(0.1f);
        squareBannerAdIndex++;
        RequestRectangleAd();
    }

    private void RequestRightBannerAd()
    {
        Debug.Log("============> Right banner is being requesting"  );
        // These ad units are configured to always serve test ads.
#if UNITY_EDITOR
        string adUnitId = "unused";
#elif UNITY_ANDROID
        string adUnitId =  AdManager.instance.RightAdmobBannerId[RightAdmobBannerId];
#elif UNITY_IPHONE
        string adUnitId = AdManager.instance.RightAdmobBannerId[RightAdmobBannerId];
#else
        string adUnitId = "unexpected_platform";
#endif

        // Clean up banner before reusing
        if (rightBannerView != null)
        {
            rightBannerView.Destroy();
            rightBannerView = null;
        }

        rightBannerView = new BannerView(adUnitId, AdSize.Banner, AdPosition.TopRight);
        var adRequest = new AdRequest();
        //leftBannerView.LoadAd(CreateAdRequest());
        rightBannerView.LoadAd(adRequest);


        rightBannerView.OnBannerAdLoaded += () =>
        {
            Debug.Log("Banner view loaded an ad with response : "
                + rightBannerView.GetResponseInfo());


        };
        // Raised when an ad fails to load into the banner view.
        rightBannerView.OnBannerAdLoadFailed += (LoadAdError error) =>
        {
            Debug.LogError("Banner view failed to load an ad with error : " + error);
            if (RightAdmobBannerId < 2 && AdManager.instance.isThreeId)
            {
                StartCoroutine(RightBannerRequestDelay());
            }
        };
        // Raised when the ad is estimated to have earned money.
        rightBannerView.OnAdPaid += (AdValue adValue) =>
        {
            Debug.Log(String.Format("Banner view paid {0} {1}.",
                adValue.Value,
                adValue.CurrencyCode));
        };
        // Raised when an impression is recorded for an ad.
        rightBannerView.OnAdImpressionRecorded += () =>
        {
            Debug.Log("Banner view recorded an impression.");
        };
        // Raised when a click is recorded for an ad.
        rightBannerView.OnAdClicked += () =>
        {
            Debug.Log("Banner view was clicked.");
        };
        // Raised when an ad opened full screen content.
        rightBannerView.OnAdFullScreenContentOpened += () =>
        {
            Debug.Log("Banner view full screen content opened.");
        };
        // Raised when the ad closed full screen content.
        rightBannerView.OnAdFullScreenContentClosed += () =>
        {
            Debug.Log("Banner view full screen content closed.");
        };

        if (rightBannerView != null)
        {
            rightBannerView.Hide();
        }
    }

    private IEnumerator RightBannerRequestDelay()
    {
        yield return new WaitForSeconds(0.1f);
        RightAdmobBannerId++;
        RequestRightBannerAd();
    }
    public void ShowRightBanner()
    {
        if (rightBannerView != null /*&& !bannerShowRequest*/)
        {
            rightBannerView.Show();
        }
    }
    public void HideRightBanner()
    {
        if (rightBannerView != null /*&& !bannerShowRequest*/)
        {
            rightBannerView.Hide();


        }
    }
    public void ShowBannerAdmob()
    {
        if (bannerView != null)
        {
            bannerView.Show();
        }

    }

    public void ShowRectangleBannerAdmob()
    {
        // Ensure that the rectBannerView is not null and show it explicitly
        if (rectBannerView != null)
        {
            rectBannerView.Show();
            Debug.Log("Rectangle Banner View  initialized properly.");
            // Ensure other banners are hidden if necessary
            // HideBannerAdmob(); // Optional: Hide simple banner if necessary
        }
        else
        {
            RequestRectangleAd();
            // Log an error or debug message to track the issue
            Debug.Log("Rectangle Banner View is null or not initialized properly.");
        }
        Debug.Log("Rectangle Banner View  initialized properly.");

    }
    public void HideBothSquareAndBanner()
    {
        if (rectBannerView != null)
        {
            rectBannerView.Hide();
        }
        if (bannerView != null)
        {
            bannerView.Hide();
        }
        //if (HomeScreen.instance)
        //{
        //    HomeScreen.instance.ShowBanner();
        //}
    }
    public void HideBannerAdmob()
    {
        if (bannerView != null)
        {
            bannerView.Hide();
        }
    }

    public void HideRectangleAdmob()
    {

        if (rectBannerView != null)
        {
            rectBannerView.Hide();
        }
        //if (leftBannerView != null)
        //{
        //    leftBannerView.Hide();
        //}
    }

    public void DestroyBannerAdAdmob()
    {
        if (bannerView != null)
        {
            bannerView.Destroy();
        }
    }

    #endregion

    #region INTERSTITIAL ADS

    public void RequestAndLoadInterstitialAd()
    {
        PrintStatus("Requesting Interstitial ad.");

#if UNITY_EDITOR
        string adUnitId = "unused";
#elif UNITY_ANDROID
        string adUnitId = AdManager.instance.AdmobInterstitialId[interstitialAdIndex];
#elif UNITY_IPHONE
        string adUnitId = AdManager.instance.AdmobInterstitialId[interstitialAdIndex];
#else
        string adUnitId = "unexpected_platform";
#endif

        // Clean up interstitial before using it
        if (interstitialAd != null)
        {
            interstitialAd.Destroy();
        }
        // Create our request used to load the ad.
        var adRequest = new AdRequest();
        InterstitialAd.Load(adUnitId, adRequest, (InterstitialAd ad, LoadAdError error) =>
        {
            // If the operation failed with a reason.
            if (error != null)
            {
                Debug.LogError("Interstitial ad failed to load an ad with error : " + error);
                return;
            }
            // If the operation failed for unknown reasons.
            // This is an unexpected error, please report this bug if it happens.
            if (ad == null)
            {
                Debug.LogError("Unexpected error: Interstitial load event fired with null ad and null error.");
                return;
            }

            // The operation completed successfully.
            Debug.Log("Interstitial ad loaded with response : " + ad.GetResponseInfo());
            interstitialAd = ad;

            // Register to ad events to extend functionality.
            RegisterEventHandlers(ad);


        });


    }
    private void RegisterEventHandlers(InterstitialAd ad)
    {
        // Raised when the ad is estimated to have earned money.
        ad.OnAdPaid += (AdValue adValue) =>
        {
            Debug.Log(String.Format("Interstitial ad paid {0} {1}.",
                adValue.Value,
                adValue.CurrencyCode));
        };
        // Raised when an impression is recorded for an ad.
        ad.OnAdImpressionRecorded += () =>
        {
            Debug.Log("Interstitial ad recorded an impression.");
        };
        // Raised when a click is recorded for an ad.
        ad.OnAdClicked += () =>
        {
            Debug.Log("Interstitial ad was clicked.");
        };
        // Raised when an ad opened full screen content.
        ad.OnAdFullScreenContentOpened += () =>
        {
            Debug.Log("Interstitial ad full screen content opened.");
        };
        // Raised when the ad closed full screen content.
        ad.OnAdFullScreenContentClosed += () =>
        {
            Debug.Log("Interstitial ad full screen content closed.");
        };
        // Raised when the ad failed to open full screen content.
        ad.OnAdFullScreenContentFailed += (AdError error) =>
        {
            Debug.LogError("Interstitial ad failed to open full screen content with error : "
                + error);
            if (interstitialAdIndex < 2 && AdManager.instance.isThreeId)
            {

                StartCoroutine(InterstitalRequestDelay());
            }
        };
    }
    private IEnumerator InterstitalRequestDelay()
    {
        yield return new WaitForSeconds(0.1f);
        interstitialAdIndex++;
        RequestAndLoadInterstitialAd();
    }

    public void ShowInterstitialAd()
    {
        if (interstitialAd != null && interstitialAd.CanShowAd())
        {
            interstitialAd.Show();
            Debug.Log("Interstitial ad is ready and show.");
        }
        else
        {


            //AdManager.instance.Show_Unity_Interstitial();
            RequestAndLoadInterstitialAd();
            PrintStatus("Interstitial ad is not ready yet.");
        }
    }

    public void DestroyInterstitialAd()
    {
        if (interstitialAd != null)
        {
            interstitialAd.Destroy();
        }
    }

    


        #endregion

    #region REWARDED ADS

        public void RequestAndLoadRewardedAd()
    {
        PrintStatus("Requesting Rewarded ad.");
#if UNITY_EDITOR
        string adUnitId = "unused";
#elif UNITY_ANDROID
        string adUnitId = AdManager.instance.AdmobRewardedVideoId[rewardedAdIndex];
#elif UNITY_IPHONE
        string adUnitId = AdManager.instance.AdmobRewardedVideoId[rewardedAdIndex];
#else
        string adUnitId = "unexpected_platform";
#endif

        //// create new rewarded ad instance
        //rewardedAd = new RewardedAd(adUnitId);

        // Create our request used to load the ad.
        var adRequest = new AdRequest();

        // Send the request to load the ad.
        RewardedAd.Load(adUnitId, adRequest, (RewardedAd ad, LoadAdError error) =>
        {
            // If the operation failed with a reason.
            if (error != null)
            {
                Debug.LogError("Rewarded ad failed to load an ad with error : " + error);
                return;
            }
            // If the operation failed for unknown reasons.
            // This is an unexpected error, please report this bug if it happens.
            if (ad == null)
            {
                Debug.LogError("Unexpected error: Rewarded load event fired with null ad and null error.");
                return;
            }

            // The operation completed successfully.
            Debug.Log("Rewarded ad loaded with response : " + ad.GetResponseInfo());
            rewardedAd = ad;

            // Register to ad events to extend functionality.
            RegisterEventHandlers(ad);


        });

    }
    private void RegisterEventHandlers(RewardedAd ad)
    {
        // Raised when the ad is estimated to have earned money.
        ad.OnAdPaid += (AdValue adValue) =>
        {
            Debug.Log(String.Format("Rewarded ad paid {0} {1}.",
                adValue.Value,
                adValue.CurrencyCode));
        };
        // Raised when an impression is recorded for an ad.
        ad.OnAdImpressionRecorded += () =>
        {
            Debug.Log("Rewarded ad recorded an impression.");
        };
        // Raised when a click is recorded for an ad.
        ad.OnAdClicked += () =>
        {
            Debug.Log("Rewarded ad was clicked.");
        };
        // Raised when the ad opened full screen content.
        ad.OnAdFullScreenContentOpened += () =>
        {
            Debug.Log("Rewarded ad full screen content opened.");
        };
        // Raised when the ad closed full screen content.
        ad.OnAdFullScreenContentClosed += () =>
        {
            Debug.Log("Rewarded ad full screen content closed.");
        };
        // Raised when the ad failed to open full screen content.
        ad.OnAdFullScreenContentFailed += (AdError error) =>
        {
            Debug.LogError("Rewarded ad failed to open full screen content with error : "
                + error);

            if (rewardedAdIndex < 2 && AdManager.instance.isThreeId)
            {
                StartCoroutine(RewardedRequestDelay());
            }
        };
    }

    private IEnumerator RewardedRequestDelay()
    {
        yield return new WaitForSeconds(0.1f);
        rewardedAdIndex++;
        RequestAndLoadRewardedAd();
    }


    public void ShowRewardedAd()
    {
        if (rewardedAd != null)
        {
            rewardedAd.Show((Reward reward) =>
            {
                RewardHandler.instance.GiveReward();
            });
            RequestAndLoadRewardedAd();
        }
        else
        {
            RequestAndLoadRewardedAd();
            PrintStatus("Rewarded ad is not ready yet.");
        }
    }

    public void RequestAndLoadRewardedInterstitialAd()
    {
        PrintStatus("Requesting Rewarded Interstitial ad.");

        // These ad units are configured to always serve test ads.
#if UNITY_EDITOR
        string adUnitId = "unused";
#elif UNITY_ANDROID
            string adUnitId = AdManager.instance.AdmobInterstitialRewardedId;
#elif UNITY_IPHONE
            string adUnitId = AdManager.instance.AdmobInterstitialRewardedId;
#else
            string adUnitId = "unexpected_platform";
#endif

        // Create an interstitial.
        RewardedInterstitialAd.Load(adUnitId, CreateAdRequest(), (rewardedInterstitialAd, error) =>
        {
            if (error != null)
            {
                PrintStatus("Rewarded Interstitial ad load failed with error: " + error);
                return;
            }

            this.rewardedInterstitialAd = rewardedInterstitialAd;
            PrintStatus("Rewarded Interstitial ad loaded.");

            // Register for ad events.

            RegisterEventHandlers(rewardedInterstitialAd);
        });
    }
    protected void RegisterEventHandlers(RewardedInterstitialAd ad)
    {
        // Raised when the ad is estimated to have earned money.
        ad.OnAdPaid += (AdValue adValue) =>
        {
            Debug.Log(String.Format("Rewarded interstitial ad paid {0} {1}.",
                adValue.Value,
                adValue.CurrencyCode));
        };
        // Raised when an impression is recorded for an ad.
        ad.OnAdImpressionRecorded += () =>
        {
            Debug.Log("Rewarded interstitial ad recorded an impression.");
        };
        // Raised when a click is recorded for an ad.
        ad.OnAdClicked += () =>
        {
            Debug.Log("Rewarded interstitial ad was clicked.");
        };
        // Raised when an ad opened full screen content.
        ad.OnAdFullScreenContentOpened += () =>
        {
            Debug.Log("Rewarded interstitial ad full screen content opened.");
        };
        // Raised when the ad closed full screen content.
        ad.OnAdFullScreenContentClosed += () =>
        {
            Debug.Log("Rewarded interstitial ad full screen content closed.");
        };
        // Raised when the ad failed to open full screen content.
        ad.OnAdFullScreenContentFailed += (AdError error) =>
        {
            Debug.LogError("Rewarded interstitial ad failed to open full screen content" +
                           " with error : " + error);
        };
    }
    public void ShowRewardedInterstitialAd()
    {
        if (rewardedInterstitialAd != null)
        {
            rewardedInterstitialAd.Show((reward) =>
            {
                PrintStatus("Rewarded Interstitial ad Rewarded : " + reward.Amount);
                RequestAndLoadRewardedInterstitialAd();
            });
        }
        else
        {
            PrintStatus("Rewarded Interstitial ad is not ready yet.");
        }
    }

    #endregion

    #region Utility

    ///<summary>
    /// Log the message and update the status text on the main thread.
    ///<summary>
    private void PrintStatus(string message)
    {
        Debug.Log(message);

    }

    #endregion

    //////////////////////////APP OPEN//////////////////////////////////////////////////

   
    public AppOpenAd _appOpenAd;
    


    private void LoadAppOpenAd()
    {
#if UNITY_EDITOR
        const string adUnitId = "unused";
#elif UNITY_ANDROID
         string adUnitId = AdManager.instance.AppOpenId[AppOpenIndex];
#elif UNITY_IPHONE
       string adUnitId = AdManager.instance.AppOpenId[AppOpenIndex];
#else
        string adUnitId = "unexpected_platform";
#endif
        if (_appOpenAd != null)
        {
            _appOpenAd.Destroy();
            _appOpenAd = null;
        }

        // Create our request used to load the ad.
        var adRequest = new AdRequest();

        // send the request to load the ad.
        AppOpenAd.Load(adUnitId, adRequest,
            (AppOpenAd ad, LoadAdError error) =>
            {
                // if error is not null, the load request failed.
                if (error != null || ad == null)
                {
                    if (AppOpenIndex < 2 && AdManager.instance.isThreeId)
                    {
                        StartCoroutine(AppOpenRequestDelay());
                    }
                    return;
                }
                _appOpenAd = ad;
                RegisterEventHandlers(ad);
                
            });
        
    }
    private void RegisterEventHandlers(AppOpenAd ad)
    {
        // Raised when the ad is estimated to have earned money.
        ad.OnAdPaid += (AdValue adValue) =>
        {
            Debug.Log(String.Format("App open ad paid {0} {1}.",
                adValue.Value,
                adValue.CurrencyCode));
        };
        // Raised when an impression is recorded for an ad.
        ad.OnAdImpressionRecorded += () =>
        {
            Debug.Log("App open ad recorded an impression.");
        };
        // Raised when a click is recorded for an ad.
        ad.OnAdClicked += () =>
        {
            Debug.Log("App open ad was clicked.");
        };
        // Raised when an ad opened full screen content.
        ad.OnAdFullScreenContentOpened += () =>
        {
            Debug.Log("App open ad full screen content opened.");
        };
        // Raised when the ad closed full screen content.
        ad.OnAdFullScreenContentClosed += () =>
        {
            Debug.Log("App open ad full screen content closed.");
        };
        // Raised when the ad failed to open full screen content.
        ad.OnAdFullScreenContentFailed += (AdError error) =>
        {
            Debug.LogError("App open ad failed to open full screen content " +
                           "with error : " + error);
        };
    }

    private IEnumerator AppOpenRequestDelay()
    {
        yield return new WaitForSeconds(0.1f);
        AppOpenIndex++;
        LoadAppOpenAd();
    }
    private void RegisterReloadHandler(AppOpenAd ad)
    {
        ad.OnAdFullScreenContentClosed += LoadAppOpenAd;
        ad.OnAdFullScreenContentFailed += error =>
        {
            ad.Destroy();
            LoadAppOpenAd();
        };
    }
    public void ShowAppOpenAd()
    {
        if (_appOpenAd != null && _appOpenAd.CanShowAd())
        {
            Debug.Log("Showing app open ad.");
            _appOpenAd.Show();
            RegisterReloadHandler(_appOpenAd);
        }
        else
        {
            Debug.LogError("App open ad is not ready yet.");
        }
    }

}
