using GoogleMobileAds.Api;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Advertisements;

public class AdManager : MonoBehaviour
{
    public static AdManager instance;

    #region UNITY Variables

    [Space]
    [Header("Testing Ads")]
    //========== Is Ads Testing =============
    public bool TestAds;

    public bool isThreeId;

    [Header("AdMob IDs")]
    //========== Admob Android Ids ==========

    public string AdmobAppId;
    public List<string> AdmobBannerId;
    public List<string> RightAdmobBannerId;
    //public <List>string AdmobBannerId;

    public List<string> AdmobSquareBannerId;
    public List<string> AdmobInterstitialId;

    public string AdmobInterstitialRewardedId;
    public List<string> AppOpenId;
    public List<string> AdmobRewardedVideoId;

   

    //  [Header("Unity Ad ID")]
    //========== Unity Ad ids =============
    /* 
        public string UnityGameID;
        public string UnityBannerID;
        public string UnityInterstitialID;
        public string UnityRewardedID;
    */


    [Space]
    [Header("Banner Ads Position")]
    //========== Banner Ads Position =============
    public AdPosition Admob_Banner_Position = AdPosition.Bottom;
    //  public BannerPosition Unity_Banner_Position = BannerPosition.BOTTOM_CENTER;

    [Space]
    [Header("Banner Ads Size")]
    //========== Banner Ads Size =============
    public bool Admob_Banner_Simple;
    public bool Admob_Banner_Smart;



    [Header("Scripts Reff")]
    //========== Is Ads Testing =============
    public GameObject GoogleAds;
    // public GameObject UnityAds;


    //========== Don't Change Any code From here to down =============
   public GoogleAdMobManager Google_Ads_Manager;
    /*  
        BannerAdUnity Unity_Banner_Manager;
        InterstitialAdUnity Unity_Interstitial_Manager;
        RewardedAdsUnity Unity_Rewarded_Manager;
    */
    [HideInInspector]


    public enum RewardedAdPlacement
    {
        ReviveAds,
        GetCoins,
        GetPowerup,
        GetFuelStamina,
        CharacterCarPurchaseRV
    }

    #endregion

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



    private void Start()
    {
        /*      AppLovinAndAdmobManager.instance.AdmobStateCheck(RemoteConfigManager.instance.enab);
              AppLovinAndAdmobManager.instance.AppLovinStateCheck(true);*/

        if (RemoteConfigManager.instance.isAdmobEnable)
        {
            Google_Ads_Manager = GoogleAds.GetComponent<GoogleAdMobManager>();
        }

        /*        Unity_Banner_Manager = UnityAds.GetComponent<BannerAdUnity>();
                Unity_Interstitial_Manager = UnityAds.GetComponent<InterstitialAdUnity>();
                Unity_Rewarded_Manager = UnityAds.GetComponent<RewardedAdsUnity>();*/


        if (TestAds == true)
        {
            // Admob_Test_Ads 

            AdmobAppId = "ca-app-pub-7906320304267948~9371111224";
            AdmobBannerId[0] = "ca-app-pub-3940256099942544/6300978111";
            RightAdmobBannerId[0] = "ca-app-pub-3940256099942544/6300978111";
            AdmobSquareBannerId[0] = "ca-app-pub-3940256099942544/6300978111";
            AdmobInterstitialId[0] = "ca-app-pub-3940256099942544/1033173712";
            AdmobInterstitialRewardedId = "ca-app-pub-3940256099942544/5354046379";
            AdmobRewardedVideoId[0] = "ca-app-pub-3940256099942544/5224354917";
            AppOpenId[0] = "ca-app-pub-3940256099942544/9257395921";

            // Unity_Test_Ads 

            /*          UnityGameID = "4869016";
                      UnityBannerID = "Banner_iOS";
                      UnityInterstitialID = "Interstitial_iOS";
                      UnityRewardedID = "Rewarded_iOS";*/

        }
        Invoke(nameof(AdsInit), 0.2f);
    }

    public void AdsInit()
    {
        if (RemoteConfigManager.instance.isAdmobEnable)
        {

            GoogleAds.SetActive(true);
        }
        //  UnityAds.SetActive(true);
    }
    //#endregion


    #region Ads Calling

    //---------------------- Admob Calling -------------------------

    // Banner Admob
    public void Show_AdMob_Banner()
    {
        Google_Ads_Manager.ShowBannerAdmob();
    }
    public void Show_Admob_RightBanner()
    {
        Google_Ads_Manager.ShowRightBanner();
    }
    public void Hide_Admob_LeftBanner()
    {
        Google_Ads_Manager.HideRightBanner();
    }
    public void Show_AdMob_RectangleBanner()
    {
        // Google_Ads_Manager.RequestRectangleAd();
        Google_Ads_Manager.ShowRectangleBannerAdmob();
    }

    public void Hide_AdMob_Banner()
    {
        Google_Ads_Manager.HideBannerAdmob();
    }

    public void HideBothBanner()
    {
        Google_Ads_Manager.HideBothSquareAndBanner();

    }
    public void Hide_AdMob_RectangleBanner()
    {
        Google_Ads_Manager.HideRectangleAdmob();
    }

    public void Destroy_AdMob_Banner()
    {
        Google_Ads_Manager.DestroyBannerAdAdmob();
    }

    // Interstitial Admob

    public void Show_AdMob_Interstitial()
    {

        Google_Ads_Manager.ShowInterstitialAd();
    }

    // Interstitial Admob

    public void Show_AdMob_Interstitial_Rewarded()
    {
        Google_Ads_Manager.ShowRewardedInterstitialAd();
    }

    // Rewarded Admob

    public void Show_AdMob_Rewarded()
    {
        Google_Ads_Manager.ShowRewardedAd();
    }

    public void ShowAppOpenAd()
    {
       Google_Ads_Manager.ShowAppOpenAd();
    }


    //---------------------- Unity Calling -------------------------

    // Banner Unity
    #region Unity Functions

    /*    public void Show_Unity_Banner()
        {
            Unity_Banner_Manager.ShowBannerAd();
        }

        public void Hide_Unity_Banner()
        {
            Unity_Banner_Manager.HideBannerAd();
        }


        // Interstitial Unity

        public void Show_Unity_Interstitial()
        {
            Unity_Interstitial_Manager.ShowAd();
        }

    // Rewarded Unity

    public void Show_Unity_Rewarded()
    {
        Unity_Rewarded_Manager.ShowAd();
    }
    */
    #endregion

    public void OnInterstialOpening()
    {
        DisableListners();
    }

    public void OnInterstialClosed()
    {
        EnableListners();
    }

    public bool rewardCheck()
    {

        // Handle default case
        if (Google_Ads_Manager.rewardedAd.CanShowAd())
        {
            // Call Admob Character/Car Purchase on RV Ads
            return true;
        }
        else
        {
            return false;

        }

    }

    public void ShowApplovinMREC()
    {
        ApplovinAdManager.instance.ShowMRecBanner();
    }

    public void HideApplovinMREC()
    {
        ApplovinAdManager.instance.HideMRecBanner();
    }
    public void EnableListners()
    {
        var listnersObj = FindObjectsOfType<AudioListener>();

        foreach (var listener in listnersObj)
        {
            listener.enabled = true;
        }
    }

    public void DisableListners()
    {
        var listnersObj = FindObjectsOfType<AudioListener>();

        foreach (var listener in listnersObj)
        {
            listener.enabled = false;
        }
    }


}
#endregion