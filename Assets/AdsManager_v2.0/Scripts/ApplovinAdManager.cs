using System;
using UnityEngine;
using UnityEngine.UI;
//using com.adjust.sdk;

public class ApplovinAdManager : MonoBehaviour
{
    public static ApplovinAdManager instance;
    private const string MaxSdkKey = "ivPtckv78Z82IaI0tIOSwyp72lc407OIJy4UIeqIvCFWh3RNw-92GMk33T43U7LuL-pK_yHVs3R_xylu-DmHT-";

#if UNITY_IOS
    public string InterstitialAdUnitId = "ENTER_IOS_INTERSTITIAL_AD_UNIT_ID_HERE";
    public string RewardedAdUnitId = "ENTER_IOS_REWARD_AD_UNIT_ID_HERE";
    public string BannerAdUnitId = "ENTER_IOS_BANNER_AD_UNIT_ID_HERE";
    public  string MRecAdUnitId = "ENTER_IOS_MREC_AD_UNIT_ID_HERE";

    public GameObject AppTrackingPanel;
    //  private const string RewardedInterstitialAdUnitId = "ENTER_IOS_REWARD_INTER_AD_UNIT_ID_HERE";
#else // UNITY_ANDROID
    public string InterstitialAdUnitId = "75d98e6515a87634";
    public string RewardedAdUnitId = "1302b7fb9163f2ff";
    public string BannerAdUnitId = "c29d233a01829800";
    public string MRecAdUnitId = "6a55ca3895d735f1";
   // private const string RewardedInterstitialAdUnitId = "ENTER_ANDROID_REWARD_INTER_AD_UNIT_ID_HERE";
#endif

    /*    public Button showInterstitialButton;
        public Button showRewardedButton;
        public Button showRewardedInterstitialButton;
        public Button showBannerButton;
        public Button showMRecButton;*/
    //public Button mediationDebuggerButton;

    private bool _isBannerShowing;
    private bool _isMRecShowing;
    private int _interstitialRetryAttempt;
    private int _rewardedRetryAttempt;
    private int _rewardedInterstitialRetryAttempt;

    void Awake()
    {
        if (instance == null)
        {
            instance = this;
        }
        else if (instance != null)
        {
            Destroy(gameObject);
        }
        DontDestroyOnLoad(this.gameObject);


    }
    void Start()
    {
      //  mediationDebuggerButton.onClick.AddListener(MaxSdk.ShowMediationDebugger);
        MaxSdkCallbacks.OnSdkInitializedEvent += sdkConfiguration =>
        {
            // AppLovin SDK is initialized, configure and start loading ads.
            Debug.Log("MAX SDK Initialized");

            PlayerPrefs.SetInt("OnConsentGranted", 1);
            AppTrackingPanel.SetActive(true);


            InitializeInterstitialAds();
            InitializeRewardedAds();
            InitializeBannerAds();


            if(RemoteConfigManager.instance.ApplovinMREC)
            {
                InitializeMRecAds();
            }
            

         
        };

        MaxSdk.SetSdkKey(MaxSdkKey);
        MaxSdk.InitializeSdk();

    }

    #region Interstitial Ad Methods

    private void InitializeInterstitialAds()
    {
        // Attach callbacks
        MaxSdkCallbacks.Interstitial.OnAdLoadedEvent += OnInterstitialLoadedEvent;
        MaxSdkCallbacks.Interstitial.OnAdLoadFailedEvent += OnInterstitialFailedEvent;
        MaxSdkCallbacks.Interstitial.OnAdDisplayFailedEvent += InterstitialFailedToDisplayEvent;
        MaxSdkCallbacks.Interstitial.OnAdHiddenEvent += OnInterstitialDismissedEvent;
        MaxSdkCallbacks.Interstitial.OnAdRevenuePaidEvent += OnInterstitialRevenuePaidEvent;

        // Load the first interstitial
        LoadInterstitial();

    }

    void LoadInterstitial()
    {
        //interstitialStatusText.text = "Loading...";
        MaxSdk.LoadInterstitial(InterstitialAdUnitId);
    }

    public void ShowInterstitial()
    {
        if (MaxSdk.IsInterstitialReady(InterstitialAdUnitId))
        {
            MaxSdk.ShowInterstitial(InterstitialAdUnitId);
        }

    }

    private void OnInterstitialLoadedEvent(string adUnitId, MaxSdkBase.AdInfo adInfo)
    {
        // Interstitial ad is ready to be shown. MaxSdk.IsInterstitialReady(interstitialAdUnitId) will now return 'true'
        //interstitialStatusText.text = "Loaded";
        Debug.Log("Interstitial loaded");

        // showInterstitialButton.interactable = true;
        // Reset retry attempt
        _interstitialRetryAttempt = 0;
    }

    private void OnInterstitialFailedEvent(string adUnitId, MaxSdkBase.ErrorInfo errorInfo)
    {
        // Interstitial ad failed to load. We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds).
        _interstitialRetryAttempt++;
        double retryDelay = Math.Pow(2, Math.Min(6, _interstitialRetryAttempt));

        //interstitialStatusText.text = "Load failed: " + errorInfo.Code + "\nRetrying in " + retryDelay + "s...";
        Debug.Log("Interstitial failed to load with error code: " + errorInfo.Code);

        Invoke("LoadInterstitial", (float)retryDelay);
    }

    private void InterstitialFailedToDisplayEvent(string adUnitId, MaxSdkBase.ErrorInfo errorInfo, MaxSdkBase.AdInfo adInfo)
    {
        // Interstitial ad failed to display. We recommend loading the next ad
        Debug.Log("Interstitial failed to display with error code: " + errorInfo.Code);
        LoadInterstitial();
    }

    private void OnInterstitialDismissedEvent(string adUnitId, MaxSdkBase.AdInfo adInfo)
    {
        // Interstitial ad is hidden. Pre-load the next ad
        Debug.Log("Interstitial dismissed");
        LoadInterstitial();
    }

    private void OnInterstitialRevenuePaidEvent(string adUnitId, MaxSdkBase.AdInfo adInfo)
    {
        // Interstitial ad revenue paid. Use this callback to track user revenue.
        Debug.Log("Interstitial revenue paid");

        // Ad revenue
        double revenue = adInfo.Revenue;

        // Miscellaneous data
        string countryCode = MaxSdk.GetSdkConfiguration().CountryCode; // "US" for the United States, etc - Note: Do not confuse this with currency code which is "USD"!
        string networkName = adInfo.NetworkName; // Display name of the network that showed the ad (e.g. "AdColony")
        string adUnitIdentifier = adInfo.AdUnitIdentifier; // The MAX Ad Unit ID
        string placement = adInfo.Placement; // The placement this ad's postbacks are tied to


    }

    #endregion

    #region Rewarded Ad Methods

    private void InitializeRewardedAds()
    {
        // Attach callbacks
        MaxSdkCallbacks.Rewarded.OnAdLoadedEvent += OnRewardedAdLoadedEvent;
        MaxSdkCallbacks.Rewarded.OnAdLoadFailedEvent += OnRewardedAdFailedEvent;
        MaxSdkCallbacks.Rewarded.OnAdDisplayFailedEvent += OnRewardedAdFailedToDisplayEvent;
        MaxSdkCallbacks.Rewarded.OnAdDisplayedEvent += OnRewardedAdDisplayedEvent;
        MaxSdkCallbacks.Rewarded.OnAdClickedEvent += OnRewardedAdClickedEvent;
        MaxSdkCallbacks.Rewarded.OnAdHiddenEvent += OnRewardedAdDismissedEvent;
        MaxSdkCallbacks.Rewarded.OnAdReceivedRewardEvent += OnRewardedAdReceivedRewardEvent;
        MaxSdkCallbacks.Rewarded.OnAdRevenuePaidEvent += OnRewardedAdRevenuePaidEvent;

        // Load the first RewardedAd
        LoadRewardedAd();
    }

    // ReSharper disable Unity.PerformanceAnalysis
    private void LoadRewardedAd()
    {
        //rewardedStatusText.text = "Loading...";
        MaxSdk.LoadRewardedAd(RewardedAdUnitId);
    }

    public void ShowRewardedAd()
    {
        if (MaxSdk.IsRewardedAdReady(RewardedAdUnitId))
        {
            MaxSdk.ShowRewardedAd(RewardedAdUnitId);
        }

    }


    public bool RewardCheckMAX()
    {
        int numberOfTries = 3;
        int delayMilliseconds = 1000;

        for (int i = 0; i < numberOfTries; i++)
        {
            if (MaxSdk.IsRewardedAdReady(RewardedAdUnitId))
            {
                return true;

            }

            // Wait for 1 second before the next attempt
            System.Threading.Thread.Sleep(delayMilliseconds);
        }

        // If after three attempts the condition is still false, return false
        return false;
    }
    private void OnRewardedAdLoadedEvent(string adUnitId, MaxSdkBase.AdInfo adInfo)
    {
        // Rewarded ad is ready to be shown. MaxSdk.IsRewardedAdReady(rewardedAdUnitId) will now return 'true'
        //rewardedStatusText.text = "Loaded";
        Debug.Log("Rewarded ad loaded");

        // showRewardedButton.interactable = true;
        // Reset retry attempt
        _rewardedRetryAttempt = 0;
    }

    private void OnRewardedAdFailedEvent(string adUnitId, MaxSdkBase.ErrorInfo errorInfo)
    {
        // Rewarded ad failed to load. We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds).
        _rewardedRetryAttempt++;
        var retryDelay = Math.Pow(2, Math.Min(6, _rewardedRetryAttempt));

        //rewardedStatusText.text = "Load failed: " + errorInfo.Code + "\nRetrying in " + retryDelay + "s...";
        Debug.Log("Rewarded ad failed to load with error code: " + errorInfo.Code);

        Invoke("LoadRewardedAd", (float)retryDelay);

    }

    private void OnRewardedAdFailedToDisplayEvent(string adUnitId, MaxSdkBase.ErrorInfo errorInfo, MaxSdkBase.AdInfo adInfo)
    {
        // Rewarded ad failed to display. We recommend loading the next ad
        Debug.Log("Rewarded ad failed to display with error code: " + errorInfo.Code);
        LoadRewardedAd();
    }

    private void OnRewardedAdDisplayedEvent(string adUnitId, MaxSdkBase.AdInfo adInfo)
    {
        Debug.Log("Rewarded ad displayed");
    }

    private void OnRewardedAdClickedEvent(string adUnitId, MaxSdkBase.AdInfo adInfo)
    {
        Debug.Log("Rewarded ad clicked");
    }

    private void OnRewardedAdDismissedEvent(string adUnitId, MaxSdkBase.AdInfo adInfo)
    {
        // Rewarded ad is hidden. Pre-load the next ad
        Debug.Log("Rewarded ad dismissed");
        LoadRewardedAd();
    }


    private void OnRewardedAdReceivedRewardEvent(string adUnitId, MaxSdk.Reward reward, MaxSdkBase.AdInfo adInfo)
    {
        RewardHandler.instance.GiveReward();

    }

    private void OnRewardedAdRevenuePaidEvent(string adUnitId, MaxSdkBase.AdInfo adInfo)
    {
        // Rewarded ad revenue paid. Use this callback to track user revenue.

        // Ad revenue
        double revenue = adInfo.Revenue;

        // Miscellaneous data
        string countryCode = MaxSdk.GetSdkConfiguration().CountryCode; // "US" for the United States, etc - Note: Do not confuse this with currency code which is "USD"!
        string networkName = adInfo.NetworkName; // Display name of the network that showed the ad (e.g. "AdColony")
        string adUnitIdentifier = adInfo.AdUnitIdentifier; // The MAX Ad Unit ID
        string placement = adInfo.Placement; // The placement this ad's postbacks are tied to


    }

    #endregion

    #region Rewarded Interstitial Ad Methods

    private void InitializeRewardedInterstitialAds()
    {
        // Attach callbacks
        MaxSdkCallbacks.RewardedInterstitial.OnAdLoadedEvent += OnRewardedInterstitialAdLoadedEvent;
        MaxSdkCallbacks.RewardedInterstitial.OnAdLoadFailedEvent += OnRewardedInterstitialAdFailedEvent;
        MaxSdkCallbacks.RewardedInterstitial.OnAdDisplayFailedEvent += OnRewardedInterstitialAdFailedToDisplayEvent;
        MaxSdkCallbacks.RewardedInterstitial.OnAdDisplayedEvent += OnRewardedInterstitialAdDisplayedEvent;
        MaxSdkCallbacks.RewardedInterstitial.OnAdClickedEvent += OnRewardedInterstitialAdClickedEvent;
        MaxSdkCallbacks.RewardedInterstitial.OnAdHiddenEvent += OnRewardedInterstitialAdDismissedEvent;
        MaxSdkCallbacks.RewardedInterstitial.OnAdReceivedRewardEvent += OnRewardedInterstitialAdReceivedRewardEvent;
        MaxSdkCallbacks.RewardedInterstitial.OnAdRevenuePaidEvent += OnRewardedInterstitialAdRevenuePaidEvent;

        // Load the first RewardedInterstitialAd
        LoadRewardedInterstitialAd();
    }

    private void LoadRewardedInterstitialAd()
    {
        //rewardedInterstitialStatusText.text = "Loading...";
        //    MaxSdk.LoadRewardedInterstitialAd(RewardedInterstitialAdUnitId);
    }

    private void ShowRewardedInterstitialAd()
    {
        /*if (MaxSdk.IsRewardedInterstitialAdReady(RewardedInterstitialAdUnitId))
        {
            //rewardedInterstitialStatusText.text = "Showing";
            MaxSdk.ShowRewardedInterstitialAd(RewardedInterstitialAdUnitId);
        }
        else
        {
            //rewardedInterstitialStatusText.text = "Ad not ready";
        }*/
    }

    private void OnRewardedInterstitialAdLoadedEvent(string adUnitId, MaxSdkBase.AdInfo adInfo)
    {
        // Rewarded interstitial ad is ready to be shown. MaxSdk.IsRewardedInterstitialAdReady(rewardedInterstitialAdUnitId) will now return 'true'
        //rewardedInterstitialStatusText.text = "Loaded";
        Debug.Log("Rewarded interstitial ad loaded");

        // Reset retry attempt
        _rewardedInterstitialRetryAttempt = 0;
    }

    private void OnRewardedInterstitialAdFailedEvent(string adUnitId, MaxSdkBase.ErrorInfo errorInfo)
    {
        // Rewarded interstitial ad failed to load. We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds).
        _rewardedInterstitialRetryAttempt++;
        double retryDelay = Math.Pow(2, Math.Min(6, _rewardedInterstitialRetryAttempt));

        //rewardedInterstitialStatusText.text = "Load failed: " + errorInfo.Code + "\nRetrying in " + retryDelay + "s...";
        Debug.Log("Rewarded interstitial ad failed to load with error code: " + errorInfo.Code);

        Invoke("LoadRewardedInterstitialAd", (float)retryDelay);
    }

    private void OnRewardedInterstitialAdFailedToDisplayEvent(string adUnitId, MaxSdkBase.ErrorInfo errorInfo, MaxSdkBase.AdInfo adInfo)
    {
        // Rewarded interstitial ad failed to display. We recommend loading the next ad
        Debug.Log("Rewarded interstitial ad failed to display with error code: " + errorInfo.Code);
        LoadRewardedInterstitialAd();
    }

    private void OnRewardedInterstitialAdDisplayedEvent(string adUnitId, MaxSdkBase.AdInfo adInfo)
    {
        Debug.Log("Rewarded interstitial ad displayed");
    }

    private void OnRewardedInterstitialAdClickedEvent(string adUnitId, MaxSdkBase.AdInfo adInfo)
    {
        Debug.Log("Rewarded interstitial ad clicked");
    }

    private void OnRewardedInterstitialAdDismissedEvent(string adUnitId, MaxSdkBase.AdInfo adInfo)
    {
        // Rewarded interstitial ad is hidden. Pre-load the next ad
        Debug.Log("Rewarded interstitial ad dismissed");
        LoadRewardedInterstitialAd();
    }

    private void OnRewardedInterstitialAdReceivedRewardEvent(string adUnitId, MaxSdk.Reward reward, MaxSdkBase.AdInfo adInfo)
    {
        // Rewarded interstitial ad was displayed and user should receive the reward
        Debug.Log("Rewarded interstitial ad received reward");
    }

    private void OnRewardedInterstitialAdRevenuePaidEvent(string adUnitId, MaxSdkBase.AdInfo adInfo)
    {
        // Rewarded interstitial ad revenue paid. Use this callback to track user revenue.
        Debug.Log("Rewarded interstitial ad revenue paid");

        // Ad revenue
        double revenue = adInfo.Revenue;

        // Miscellaneous data
        string countryCode = MaxSdk.GetSdkConfiguration().CountryCode; // "US" for the United States, etc - Note: Do not confuse this with currency code which is "USD"!
        string networkName = adInfo.NetworkName; // Display name of the network that showed the ad (e.g. "AdColony")
        string adUnitIdentifier = adInfo.AdUnitIdentifier; // The MAX Ad Unit ID
        string placement = adInfo.Placement; // The placement this ad's postbacks are tied to


    }

    #endregion

    #region Banner Ad Methods


    private void InitializeBannerAds()
    {
        // Attach Callbacks
        MaxSdkCallbacks.Banner.OnAdLoadedEvent += OnBannerAdLoadedEvent;
        MaxSdkCallbacks.Banner.OnAdLoadFailedEvent += OnBannerAdFailedEvent;
        MaxSdkCallbacks.Banner.OnAdClickedEvent += OnBannerAdClickedEvent;
        MaxSdkCallbacks.Banner.OnAdRevenuePaidEvent += OnBannerAdRevenuePaidEvent;


        // Banners are automatically sized to 320x50 on phones and 728x90 on tablets.
        // You may use the utility method `MaxSdkUtils.isTablet()` to help with view sizing adjustments.
        MaxSdkBase.BannerPosition appLovinBannerPosition;



        switch (RemoteConfigManager.instance.ApplovinBannerPosition)
        {
            case 0:
                appLovinBannerPosition = MaxSdkBase.BannerPosition.TopCenter;
                break;
            case 1:
                appLovinBannerPosition = MaxSdkBase.BannerPosition.BottomCenter;
                break;
            case 2:
                appLovinBannerPosition = MaxSdkBase.BannerPosition.TopLeft;
                break;
            case 3:
                appLovinBannerPosition = MaxSdkBase.BannerPosition.TopRight;
                break;
            case 4:
                appLovinBannerPosition = MaxSdkBase.BannerPosition.BottomLeft;
                break;
            case 5:
                appLovinBannerPosition = MaxSdkBase.BannerPosition.BottomRight;
                break;
            default:
                appLovinBannerPosition = MaxSdkBase.BannerPosition.TopCenter;
                break;
        }

        // appLovinBannerPosition = MaxSdkBase.BannerPosition.TopCenter;
        //   // Create a banner with adaptive size
        ///*   var banner =*/ MaxSdk.CreateBanner(BannerAdUnitId,MaxSdk.bas);
        MaxSdk.CreateBanner(BannerAdUnitId, appLovinBannerPosition);
        //MaxSdk.SetBannerExtraParameter(BannerAdUnitId, "adaptive_banner", "false");

        // Set a semi-transparent black color as the background for the banner
        Color transparentBlack = new Color(0f, 0f, 0f, 0f); // Adjust the alpha value (0.5f) for transparency
        MaxSdk.SetBannerBackgroundColor(BannerAdUnitId, transparentBlack);
    }

    public void ShowBanner()
    {
        if (!_isBannerShowing)
        {
            MaxSdk.ShowBanner(BannerAdUnitId);
        }
    }
    public void HideBannerMax()
    {
        if (!_isBannerShowing)
        {
            MaxSdk.HideBanner(BannerAdUnitId);
        }
    }
    private void ToggleBannerVisibility()
    {

        if (!_isBannerShowing)
        {
            MaxSdk.ShowBanner(BannerAdUnitId);
            // showBannerButton.GetComponentInChildren<Text>().text = "Hide Banner";
        }
        else
        {
            MaxSdk.HideBanner(BannerAdUnitId);
            //  showBannerButton.GetComponentInChildren<Text>().text = "Show Banner";
        }

        _isBannerShowing = !_isBannerShowing;


    }

    private void OnBannerAdLoadedEvent(string adUnitId, MaxSdkBase.AdInfo adInfo)
    {
        // Banner ad is ready to be shown.
        // If you have already called MaxSdk.ShowBanner(BannerAdUnitId) it will automatically be shown on the next ad refresh.
        Debug.Log("Banner ad loaded");
        // showBannerButton.interactable = true;
    }

    private void OnBannerAdFailedEvent(string adUnitId, MaxSdkBase.ErrorInfo errorInfo)
    {
        // Banner ad failed to load. MAX will automatically try loading a new ad internally.
        Debug.Log("Banner ad failed to load with error code: " + errorInfo.Code);
        /* if (AdsManager.instance)
         {
             AdsManager.instance.Show_AdMob_Banner();
         }*/

    }

    private void OnBannerAdClickedEvent(string adUnitId, MaxSdkBase.AdInfo adInfo)
    {
        Debug.Log("Banner ad clicked");
    }

    private void OnBannerAdRevenuePaidEvent(string adUnitId, MaxSdkBase.AdInfo adInfo)
    {
        // Banner ad revenue paid. Use this callback to track user revenue.
        Debug.Log("Banner ad revenue paid");

        // Ad revenue
        double revenue = adInfo.Revenue;

        // Miscellaneous data
        string countryCode = MaxSdk.GetSdkConfiguration().CountryCode; // "US" for the United States, etc - Note: Do not confuse this with currency code which is "USD"!
        string networkName = adInfo.NetworkName; // Display name of the network that showed the ad (e.g. "AdColony")
        string adUnitIdentifier = adInfo.AdUnitIdentifier; // The MAX Ad Unit ID
        string placement = adInfo.Placement; // The placement this ad's postbacks are tied to


    }

    #endregion

    #region MREC Ad Methods

    private void InitializeMRecAds()
    {

        // Attach Callbacks
        MaxSdkCallbacks.MRec.OnAdLoadedEvent += OnMRecAdLoadedEvent;
        MaxSdkCallbacks.MRec.OnAdLoadFailedEvent += OnMRecAdFailedEvent;
        MaxSdkCallbacks.MRec.OnAdClickedEvent += OnMRecAdClickedEvent;
        MaxSdkCallbacks.MRec.OnAdRevenuePaidEvent += OnMRecAdRevenuePaidEvent;

        // MRECs are automatically sized to 300x250.
        MaxSdk.CreateMRec(MRecAdUnitId, MaxSdkBase.AdViewPosition.BottomLeft);
    }


    public void ShowMRecBanner()
    {
        if (RemoteConfigManager.instance.ApplovinMREC)
        {
            MaxSdk.ShowMRec(MRecAdUnitId);
        }
    }

    public void HideMRecBanner()
    {
        if (RemoteConfigManager.instance.ApplovinMREC)
        {
            MaxSdk.HideMRec(MRecAdUnitId);
        }
    }
    private void ToggleMRecVisibility()
    {
        if (RemoteConfigManager.instance.ApplovinMREC)
        {
            if (!_isMRecShowing)
            {
                MaxSdk.SetBannerWidth(MRecAdUnitId, 350);
                MaxSdk.ShowMRec(MRecAdUnitId);
                //   showMRecButton.GetComponentInChildren<Text>().text = "Hide MREC";
            }
            else
            {
                MaxSdk.HideMRec(MRecAdUnitId);
                //  showMRecButton.GetComponentInChildren<Text>().text = "Show MREC";
            }
        }
        _isMRecShowing = !_isMRecShowing;
    }

    private void OnMRecAdLoadedEvent(string adUnitId, MaxSdkBase.AdInfo adInfo)
    {
        if (RemoteConfigManager.instance.ApplovinMREC)
        {
            // MRec ad is ready to be shown.
            // If you have already called MaxSdk.ShowMRec(MRecAdUnitId) it will automatically be shown on the next MRec refresh.
            Debug.Log("MRec ad loaded");
        }
        // showMRecButton.interactable = true;
    }

    private void OnMRecAdFailedEvent(string adUnitId, MaxSdkBase.ErrorInfo errorInfo)
    {
        if (RemoteConfigManager.instance.ApplovinMREC)
        {
            // MRec ad failed to load. MAX will automatically try loading a new ad internally.
            Debug.Log("MRec ad failed to load with error code: " + errorInfo.Code);
        }
    }

    private void OnMRecAdClickedEvent(string adUnitId, MaxSdkBase.AdInfo adInfo)
    {
        Debug.Log("MRec ad clicked");
    }

    private void OnMRecAdRevenuePaidEvent(string adUnitId, MaxSdkBase.AdInfo adInfo)
    {
       
            // MRec ad revenue paid. Use this callback to track user revenue.
            Debug.Log("MRec ad revenue paid");

        // Ad revenue
        double revenue = adInfo.Revenue;

        // Miscellaneous data
        string countryCode = MaxSdk.GetSdkConfiguration().CountryCode; // "US" for the United States, etc - Note: Do not confuse this with currency code which is "USD"!
        string networkName = adInfo.NetworkName; // Display name of the network that showed the ad (e.g. "AdColony")
        string adUnitIdentifier = adInfo.AdUnitIdentifier; // The MAX Ad Unit ID
        string placement = adInfo.Placement; // The placement this ad's postbacks are tied to

    }

    #endregion

    private void OnGUI()
    {
        if (!RemoteConfigManager.instance.ApplovinTestAds) return;
        if (GUI.Button(new Rect(10, 10, 150, 100), "TEST APPLOVIN"))
        {
            MaxSdk.ShowMediationDebugger();
        }
    }
}
