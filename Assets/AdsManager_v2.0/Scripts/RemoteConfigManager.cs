using System;
using System.Collections.Generic;
//using Unity.RemoteConfig;
using Unity.Services.RemoteConfig;
using UnityEngine;
using Unity.Services.Authentication;
using Unity.Services.Core;
using System.Threading.Tasks;
using UnityEngine.Events;
using System.Collections;
// User and App attributes structs
public struct UserAttributes { }
public struct AppAttributes { }

public class RemoteConfigManager : MonoBehaviour
{
    // Singleton instance
    public static RemoteConfigManager instance;

    // Reference to game objects managing ads
    public GameObject ApplovinManager;
    public GameObject GoogleAdmobAdsManager;
    // public GameObject appOpen;
    public AdManager ads_manager;
    public ApplovinAdManager ads_managerApplovin;

    [HideInInspector]
    public bool isAdmobEnable, isApplovinEnable;

    // Whether ads are enabled
    [HideInInspector] public bool isAdsEnable;
    public UnityEvent OnEnableDelayEvent;
    public float delayToEnableAds;



    // Bool properties corresponding to each enum value
    public bool ApplovinTestAds { get; private set; }
    public bool Play { get; private set; }
    public bool CharacterSelection { get; private set; }
    public bool ModeSelection { get; private set; }
    public bool LevelSelection { get; private set; }
    public bool Pause { get; private set; }
    public bool LevelComplete { get; private set; }
    public bool Failed { get; private set; }
    public bool Setting { get; private set; }
    public bool InGameInventory { get; private set; }
    public bool ShowApplovinInterstitial { get; private set; }
    public bool ShowApplovinRewarded { get; private set; }
    public bool ApplovinMREC { get; private set; }


    // Banner Ads
    public bool SmartBanner { get; private set; }
    public bool SimpleBanner { get; private set; }
    public bool TopRightSmallBannerAdmob { get; private set; }
    public bool TopLeftSmallBannerMediation { get; private set; }
    public bool TwoSmallBannerAppLovinAndAdmob { get; private set; }


    // Rewarded Ads
    public bool ReviveAds { get; private set; }
    public bool GetCoins { get; private set; }
    public bool GetPowerup { get; private set; }
    public bool GetFuelStamina { get; private set; }
    public bool CharacterCarPurchaseRV { get; private set; }
    public bool ShopItem { get; private set; }

    public bool RewardCheck { get; private set; }
    public bool interstitialCheck { get; private set; }

    public bool BannerCheckAllApplovinAndAdmob { get; private set; }
    public bool SquareBannerCheck { get; private set; }
    public bool EnableAppOpenAD { get; private set; }
    public int AdDivisionValue { get; private set; }
    //public bool AppOpenLandScape { get; private set; }
    public int ApplovinBannerPosition;



    void OnEnable()
    {
        StartCoroutine(DelayOnEnable());

    
    }

    IEnumerator DelayOnEnable()
    {
        yield return new WaitForSeconds(delayToEnableAds);
        if (RemoteConfigService.Instance.appConfig.GetBool("EnableAds"))
        {
            OnEnableDelayEvent?.Invoke();
        }
    }



    async Task InitializeRemoteConfigAsync()
    {
        // initialize handlers for unity game services
        await UnityServices.InitializeAsync();

        // options can be passed in the initializer, e.g if you want to set analytics-user-id or an environment-name use the lines from below:
        // var options = new InitializationOptions()
        //   .SetOption("com.unity.services.core.analytics-user-id", "my-user-id-1234")
        //   .SetOption("com.unity.services.core.environment-name", "production");
        // await UnityServices.InitializeAsync(options);

        // remote config requires authentication for managing environment information
        if (!AuthenticationService.Instance.IsSignedIn)
        {
            await AuthenticationService.Instance.SignInAnonymouslyAsync();
        }
    }

    // Retrieve and apply the current key-value pairs from the service on Awake:
    async Task Awake()
    {

        // initialize Unity's authentication and core services, however check for internet connection
        // in order to fail gracefully without throwing exception if connection does not exist
        if (Utilities.CheckForInternetConnection())
        {
            await InitializeRemoteConfigAsync();
        }

        // Add a listener to apply settings when successfully retrieved:
        RemoteConfigService.Instance.FetchCompleted += AdsStatus;

        //Set the user s unique ID:
        //RemoteConfigService.Instance.SetCustomUserID("some-user-id");

        //Set the environment ID:
        //RemoteConfigService.Instance.SetEnvironmentID("an-env-id");

        // Fetch configuration settings from the remote service:
        RemoteConfigService.Instance.FetchConfigs<UserAttributes, AppAttributes>(new UserAttributes(), new AppAttributes());

        if (instance != null)
        {
            Destroy(gameObject);
            return;
        }

        instance = this;
        DontDestroyOnLoad(gameObject);

    }
 
    void AdsStatus(ConfigResponse response)
    {
        Debug.Log("Fetch " + RemoteConfigService.Instance.appConfig.GetBool("EnableAds"));
        // Retrieving boolean values from Remote Config
        bool AdsEnable = RemoteConfigService.Instance.appConfig.GetBool("EnableAds");

        ApplovinTestAds = RemoteConfigService.Instance.appConfig.GetBool("ApplovinTestAds");
        isAdmobEnable = RemoteConfigService.Instance.appConfig.GetBool("EnableAdmob");
        isApplovinEnable = RemoteConfigService.Instance.appConfig.GetBool("EnableApplovin");
        bool Admob3Ids = RemoteConfigService.Instance.appConfig.GetBool("Admob3Ids");
     //   bool EnableAppOpenAD = RemoteConfigService.Instance.appConfig.GetBool("EnableAppOpenAD");
        ads_manager.TestAds = RemoteConfigService.Instance.appConfig.GetBool("EnableTestAds");
       // AppOpenLandScape = RemoteConfigService.Instance.appConfig.GetBool("AppOpenLandScape");
        TwoSmallBannerAppLovinAndAdmob = RemoteConfigService.Instance.appConfig.GetBool("TwoSmallBannerAppLovinAndAdmob");
        TopLeftSmallBannerMediation = RemoteConfigService.Instance.appConfig.GetBool("TopLeftSmallBannerMediation");
        TopRightSmallBannerAdmob = RemoteConfigService.Instance.appConfig.GetBool("TopRightSmallBannerAdmob");



        // Fetching bool values for each enum value from Remote Config
        Play = RemoteConfigService.Instance.appConfig.GetBool("Play");
        CharacterSelection = RemoteConfigService.Instance.appConfig.GetBool("CharacterSelection");
        ModeSelection = RemoteConfigService.Instance.appConfig.GetBool("ModeSelection");
        LevelSelection = RemoteConfigService.Instance.appConfig.GetBool("LevelSelection");
        Pause = RemoteConfigService.Instance.appConfig.GetBool("Pause");
        LevelComplete = RemoteConfigService.Instance.appConfig.GetBool("LevelComplete");
        Failed = RemoteConfigService.Instance.appConfig.GetBool("Failed");
        Setting = RemoteConfigService.Instance.appConfig.GetBool("Setting");
        InGameInventory = RemoteConfigService.Instance.appConfig.GetBool("InGameInventory");
        ShowApplovinInterstitial = RemoteConfigService.Instance.appConfig.GetBool("ShowApplovinInterstitial");
        ShowApplovinRewarded = RemoteConfigService.Instance.appConfig.GetBool("ShowApplovinRewarded");
        ApplovinMREC = RemoteConfigService.Instance.appConfig.GetBool("ApplovinMREC");
        EnableAppOpenAD = RemoteConfigService.Instance.appConfig.GetBool("EnableAppOpenAD");

        // Fetching bool values for each ad placement from Remote Config
        SmartBanner = RemoteConfigService.Instance.appConfig.GetBool("SmartBannerBool");
        SimpleBanner = RemoteConfigService.Instance.appConfig.GetBool("SimpleBannerBool");
        TopRightSmallBannerAdmob = RemoteConfigService.Instance.appConfig.GetBool("TopRightSmallBannerAdmob");
        ApplovinBannerPosition = RemoteConfigService.Instance.appConfig.GetInt("ApplovinBannerPosition");

        ReviveAds = RemoteConfigService.Instance.appConfig.GetBool("ReviveAds");
        GetCoins = RemoteConfigService.Instance.appConfig.GetBool("GetCoinsRewardAds");
        GetPowerup = RemoteConfigService.Instance.appConfig.GetBool("GetPowerupRewardAds");
        GetFuelStamina = RemoteConfigService.Instance.appConfig.GetBool("GetFuelStaminaRewardAds");
        CharacterCarPurchaseRV = RemoteConfigService.Instance.appConfig.GetBool("CharacterCarPurchaseRVRewardAds");
        ShopItem = RemoteConfigService.Instance.appConfig.GetBool("ShopItem");


        RewardCheck = RemoteConfigService.Instance.appConfig.GetBool("RewardCheckAll");
        interstitialCheck = RemoteConfigService.Instance.appConfig.GetBool("interstitialCheckAll");
        BannerCheckAllApplovinAndAdmob = RemoteConfigService.Instance.appConfig.GetBool("BannerCheckAllApplovinAndAdmob");
        SquareBannerCheck = RemoteConfigService.Instance.appConfig.GetBool("SquareBannerCheckAll");
        AdDivisionValue = RemoteConfigService.Instance.appConfig.GetInt("AdDivisionValue");
        isAdsEnable = AdsEnable;
        ads_manager.isThreeId = Admob3Ids;



        // If ads are disabled, destroy relevant GameObjects and return
        if (!AdsEnable)
        {
            Destroy(GoogleAdmobAdsManager);
            Destroy(ApplovinManager);
         //   Destroy(appOpen);
            return;
        }

        //  Debug.Log("fatch id" + RemoteConfigService.Instance.appConfig.GetString("AppOpen_AD_ID(0)"));
        // Retrieving ad IDs from Remote Config based on conditions
        if (Admob3Ids)
        {
            ads_manager.AdmobBannerId = GetAdsList("Banner_AD_ID", 3);
            ads_manager.AdmobSquareBannerId = GetAdsList("Square_Banner_AD_ID", 3);
            ads_manager.AdmobInterstitialId = GetAdsList("interstitial_ID", 3);
            ads_manager.AdmobRewardedVideoId = GetAdsList("Rewarded_AD_ID", 3);
            ads_manager.RightAdmobBannerId = GetAdsList("RightBanner_AD_ID", 3);
            ads_manager.AppOpenId = GetAdsList("AppOpen_AD_ID", 3);

        }
        else
        {
            ads_manager.AdmobBannerId = GetAdsList("Banner_AD_ID", 1);
            ads_manager.AdmobSquareBannerId = GetAdsList("Square_Banner_AD_ID", 1);
            ads_manager.AdmobInterstitialId = GetAdsList("interstitial_ID", 1);
            ads_manager.AdmobRewardedVideoId = GetAdsList("Rewarded_AD_ID", 1);
            ads_manager.RightAdmobBannerId = GetAdsList("RightBanner_AD_ID", 1);
            ads_manager.AppOpenId = GetAdsList("AppOpen_AD_ID", 1);
        }
       
        //Retrieving ad IDs of Applovin from Remote Config based on conditions

        ads_managerApplovin.InterstitialAdUnitId = RemoteConfigService.Instance.appConfig.GetString("AppLovinInterstitialAdID");
        ads_managerApplovin.BannerAdUnitId = RemoteConfigService.Instance.appConfig.GetString("AppLovinBannerAdID");
       // ads_managerApplovin.MRecAdUnitId = RemoteConfigService.Instance.appConfig.GetString("AppLovinMRecAdID");
        ads_managerApplovin.RewardedAdUnitId = RemoteConfigService.Instance.appConfig.GetString("AppLovinRewardedAdID");

        // Managing ads GameObjects based on Remote Config values
/*        if (EnableAppOpenAD)

            appOpen.SetActive(true);

        else
            Destroy(appOpen.gameObject);*/

        if (isAdmobEnable)
            GoogleAdmobAdsManager.SetActive(true);
        else
            Destroy(GoogleAdmobAdsManager.gameObject);

        if (isApplovinEnable)
            ApplovinManager.SetActive(true);
        else
            Destroy(ApplovinManager);
    }

    // Method to retrieve a list of ad IDs from Remote Config
    List<string> GetAdsList(string identifier, int count)
    {
        List<string> adsList = new List<string>();
        for (int i = 0; i < count; i++)
        {
            var adId = RemoteConfigService.Instance.appConfig.GetString($"{identifier}({i})");
            adsList.Add(adId);
        }
        return adsList;
    }
}
