using System.Collections;
using UnityEngine;

public class AppLovinAndAdmobManager : MonoBehaviour
{
    public static AppLovinAndAdmobManager instance;
    /*    bool applovinCheck;
        bool admobCheck;*/
    [HideInInspector]
    public bool rewards;

    public enum InterstitialAdPlacement
    {
        Play,
        CharacterSelection,
        ModeSelection,
        LevelSelection,
        Pause,
        Complete,
        Failed,
        Setting,
        InGameInventory
    }
    public enum RewardedAdPlacement
    {
        ReviveAds,
        GetCoins,
        GetPowerup,
        GetFuelStamina,
        CharacterCarPurchaseRV,
        ShopItem
    }
    private void Awake()
    {
        if (instance == null)
        {
            instance = this;
            DontDestroyOnLoad(gameObject);
        }
        else
        {
            Destroy(gameObject);
        }
    }

    /*    public void AppLovinStateCheck(bool state)
        {
            applovinCheck = state;
        }
        public void AdmobStateCheck(bool state)
        {
          admobCheck = state;
        }*/

    bool isAdmobAdsEnable, isApplovinAdsEnable;
    private void Start()
    {
        isAdmobAdsEnable = RemoteConfigManager.instance.isAdmobEnable;
        isApplovinAdsEnable = RemoteConfigManager.instance.isApplovinEnable;
    }
    public void ShowBanner()
    {
        if (RemoteConfigManager.instance.BannerCheckAllApplovinAndAdmob)
        {

            if (!RemoteConfigManager.instance.TwoSmallBannerAppLovinAndAdmob)
            {
                if (isAdmobAdsEnable)
                {
                    AdManager.instance.Show_AdMob_Banner();

                }
                else if (isApplovinAdsEnable)
                {
                    ApplovinAdManager.instance.ShowBanner();
                }
                else
                {
                    Debug.Log("Please Enable ads From Remote Config ");
                }
            }

            else
            {
                if (isAdmobAdsEnable)
                {
                    if (RemoteConfigManager.instance.TopRightSmallBannerAdmob)
                    {
                        if (AdManager.instance)
                        {
                            StartCoroutine(ShowAdmobRightBanner());
                        }
                    }

                }
                if (RemoteConfigManager.instance.TopLeftSmallBannerMediation)
                {
                    if (AdManager.instance)
                    {
                        if (isApplovinAdsEnable)
                        {
                            ApplovinAdManager.instance.ShowBanner();
                        }
                    }
                }

            }
        }

    }

    private IEnumerator ShowAdmobRightBanner()
    {
        yield return new WaitForSeconds(1f);
        AdManager.instance.Show_Admob_RightBanner();
    }
    public void ShowInterstitial(InterstitialAdPlacement interstitialAdPlacement)
    {
        if (RemoteConfigManager.instance.interstitialCheck)
        {
            if (isApplovinAdsEnable && RemoteConfigManager.instance.ShowApplovinInterstitial)
            {
                switch (interstitialAdPlacement)
                {
                    case InterstitialAdPlacement.Play:
                        if (RemoteConfigManager.instance.Play)
                        {
                            ApplovinAdManager.instance.ShowInterstitial();
                        }
                        break;
                    case InterstitialAdPlacement.CharacterSelection:
                        if (RemoteConfigManager.instance.CharacterSelection)
                        {
                            ApplovinAdManager.instance.ShowInterstitial();
                        }
                        break;
                    case InterstitialAdPlacement.ModeSelection:
                        if (RemoteConfigManager.instance.ModeSelection)
                        {
                            Debug.Log("i am interstitial mode");
                            ApplovinAdManager.instance.ShowInterstitial();
                        }
                        break;
                    case InterstitialAdPlacement.LevelSelection:
                        if (RemoteConfigManager.instance.LevelSelection)
                        {
                            ApplovinAdManager.instance.ShowInterstitial();
                        }
                        break;
                    case InterstitialAdPlacement.Pause:
                        if (RemoteConfigManager.instance.Pause)
                        {
                            ApplovinAdManager.instance.ShowInterstitial();
                        }
                        break;
                    case InterstitialAdPlacement.Complete:
                        if (RemoteConfigManager.instance.LevelComplete)
                        {
                            ApplovinAdManager.instance.ShowInterstitial();
                        }
                        break;
                    case InterstitialAdPlacement.Failed:
                        if (RemoteConfigManager.instance.Failed)
                        {
                            ApplovinAdManager.instance.ShowInterstitial();
                        }
                        break;
                    case InterstitialAdPlacement.Setting:
                        if (RemoteConfigManager.instance.Setting)
                        {
                            ApplovinAdManager.instance.ShowInterstitial();
                        }
                        break;
                    case InterstitialAdPlacement.InGameInventory:
                        if (RemoteConfigManager.instance.InGameInventory)
                        {
                            ApplovinAdManager.instance.ShowInterstitial();
                        }
                        break;
                    default:
                        // Handle default case
                        break;
                }

            }
            else if (isAdmobAdsEnable)
            {
                switch (interstitialAdPlacement)
                {
                    case InterstitialAdPlacement.Play:
                        if (RemoteConfigManager.instance.Play)
                        {
                            AdManager.instance.Show_AdMob_Interstitial();
                        }
                        break;
                    case InterstitialAdPlacement.CharacterSelection:
                        if (RemoteConfigManager.instance.CharacterSelection)
                        {
                            AdManager.instance.Show_AdMob_Interstitial();
                        }
                        break;
                    case InterstitialAdPlacement.ModeSelection:
                        if (RemoteConfigManager.instance.ModeSelection)
                        {
                            AdManager.instance.Show_AdMob_Interstitial();
                        }
                        break;
                    case InterstitialAdPlacement.LevelSelection:
                        if (RemoteConfigManager.instance.LevelSelection)
                        {
                            AdManager.instance.Show_AdMob_Interstitial();
                        }
                        break;
                    case InterstitialAdPlacement.Pause:
                        if (RemoteConfigManager.instance.Pause)
                        {
                            AdManager.instance.Show_AdMob_Interstitial();
                        }
                        break;
                    case InterstitialAdPlacement.Complete:
                        if (RemoteConfigManager.instance.LevelComplete)
                        {
                            AdManager.instance.Show_AdMob_Interstitial();
                        }
                        break;
                    case InterstitialAdPlacement.Failed:
                        if (RemoteConfigManager.instance.Failed)
                        {
                            AdManager.instance.Show_AdMob_Interstitial();
                        }
                        break;
                    case InterstitialAdPlacement.Setting:
                        if (RemoteConfigManager.instance.Setting)
                        {
                            AdManager.instance.Show_AdMob_Interstitial();
                        }
                        break;
                    case InterstitialAdPlacement.InGameInventory:
                        if (RemoteConfigManager.instance.InGameInventory)
                        {
                            AdManager.instance.Show_AdMob_Interstitial();
                        }
                        break;
                    default:
                        // Handle default case
                        break;
                }

            }
            else
            {
                Debug.Log("Please Enable ads From Remote Config ");
            }
        }

    }
    /* public bool RewardChecks(RewardedAdPlacement rewardedAdPlacement)
     {
         bool rewardCheck;
         if (RemoteConfigManager.instance.RewardCheck)
         {
             if (isApplovinAdsEnable || isAdmobAdsEnable)
             {
                 switch (rewardedAdPlacement)
                 {
                     case RewardedAdPlacement.ReviveAds:
                         if (RemoteConfigManager.instance.ReviveAds && (AdManager.instance.rewardCheck()
                             || ApplovinAdManager.instance.RewardCheckMAX()))
                         {
                             // Call Admob Revive Ads
                             rewardCheck = true;
                         }
                         else
                         {
                             rewardCheck = false;

                         }
                         break;
                     case RewardedAdPlacement.GetCoins:
                         if (RemoteConfigManager.instance.GetCoins && (AdManager.instance.rewardCheck()
                             || ApplovinAdManager.instance.RewardCheckMAX()))
                         {
                             // Call Admob Get Coins Ads
                             rewardCheck = true;
                         }
                         else
                         {
                             rewardCheck = false;

                         }
                         break;
                     case RewardedAdPlacement.GetPowerup:
                         if (RemoteConfigManager.instance.GetPowerup && (AdManager.instance.rewardCheck()
                             || ApplovinAdManager.instance.RewardCheckMAX()))
                         {
                             // Call Admob Get Powerup Ads
                             rewardCheck = true;
                         }
                         else
                         {
                             rewardCheck = false;

                         }
                         break;
                     case RewardedAdPlacement.GetFuelStamina:
                         if (RemoteConfigManager.instance.GetFuelStamina && (AdManager.instance.rewardCheck()
                             || ApplovinAdManager.instance.RewardCheckMAX()))
                         {
                             // Call Admob Get Fuel/Stamina Ads
                             rewardCheck = true;
                         }
                         else
                         {
                             rewardCheck = false;

                         }
                         break;
                     case RewardedAdPlacement.CharacterCarPurchaseRV:
                         if (RemoteConfigManager.instance.CharacterCarPurchaseRV 
                             && (AdManager.instance.rewardCheck() || ApplovinAdManager.instance.RewardCheckMAX()))
                         {
                             // Call Admob Character/Car Purchase on RV Ads
                             rewardCheck = true;
                         }
                         else
                         {
                             rewardCheck = false;

                         }
                         break;        
                     case RewardedAdPlacement.ShopItem:
                         if (RemoteConfigManager.instance.ShopItem && (AdManager.instance.rewardCheck() 
                             || ApplovinAdManager.instance.RewardCheckMAX()))
                         {
                             // Call Admob Character/Car Purchase on RV Ads
                             rewardCheck = true;
                         }
                         else
                         {
                             rewardCheck = false;

                         }
                         break;
                     default:
                         rewardCheck = false;
                         break;
                 }
             }
             else if (isApplovinAdsEnable)
             {
                 switch (rewardedAdPlacement)
                 {
                     case RewardedAdPlacement.ReviveAds:
                         if (RemoteConfigManager.instance.ReviveAds && (ApplovinAdManager.instance.RewardCheckMAX()))
                         {
                             // Call Admob Revive Ads
                             rewardCheck = true;
                         }
                         else
                         {
                             rewardCheck = false;

                         }
                         break;
                     case RewardedAdPlacement.GetCoins:
                         if (RemoteConfigManager.instance.GetCoins && (ApplovinAdManager.instance.RewardCheckMAX()))
                         {
                             // Call Admob Get Coins Ads
                             rewardCheck = true;
                         }
                         else
                         {
                             rewardCheck = false;

                         }
                         break;
                     case RewardedAdPlacement.GetPowerup:
                         if (RemoteConfigManager.instance.GetPowerup && (ApplovinAdManager.instance.RewardCheckMAX()))
                         {
                             // Call Admob Get Powerup Ads
                             rewardCheck = true;
                         }
                         else
                         {
                             rewardCheck = false;

                         }
                         break;
                     case RewardedAdPlacement.GetFuelStamina:
                         if (RemoteConfigManager.instance.GetFuelStamina && (ApplovinAdManager.instance.RewardCheckMAX()))
                         {
                             // Call Admob Get Fuel/Stamina Ads
                             rewardCheck = true;
                         }
                         else
                         {
                             rewardCheck = false;

                         }
                         break;
                     case RewardedAdPlacement.CharacterCarPurchaseRV:
                         if (RemoteConfigManager.instance.CharacterCarPurchaseRV && (ApplovinAdManager.instance.RewardCheckMAX()))
                         {
                             // Call Admob Character/Car Purchase on RV Ads
                             rewardCheck = true;
                         }
                         else
                         {
                             rewardCheck = false;

                         }
                         break;    
                     case RewardedAdPlacement.ShopItem:
                         if (RemoteConfigManager.instance.ShopItem && (ApplovinAdManager.instance.RewardCheckMAX()))
                         {
                             // Call Admob Character/Car Purchase on RV Ads
                             rewardCheck = true;
                         }
                         else
                         {
                             rewardCheck = false;

                         }
                         break;
                     default:
                         rewardCheck = false;
                         break;
                 }

             }
             else if (isAdmobAdsEnable)
             {
                 switch (rewardedAdPlacement)
                 {
                     case RewardedAdPlacement.ReviveAds:
                         if (RemoteConfigManager.instance.ReviveAds && (AdManager.instance.rewardCheck()))
                         {
                             // Call Admob Revive Ads
                             rewardCheck = true;
                         }
                         else
                         {
                             rewardCheck = false;

                         }
                         break;
                     case RewardedAdPlacement.GetCoins:
                         if (RemoteConfigManager.instance.GetCoins && (AdManager.instance.rewardCheck()))
                         {
                             // Call Admob Get Coins Ads
                             rewardCheck = true;
                         }
                         else
                         {
                             rewardCheck = false;

                         }
                         break;
                     case RewardedAdPlacement.GetPowerup:
                         if (RemoteConfigManager.instance.GetPowerup && (AdManager.instance.rewardCheck()))
                         {
                             // Call Admob Get Powerup Ads
                             rewardCheck = true;
                         }
                         else
                         {
                             rewardCheck = false;

                         }
                         break;
                     case RewardedAdPlacement.GetFuelStamina:
                         if (RemoteConfigManager.instance.GetFuelStamina && (AdManager.instance.rewardCheck()))
                         {
                             // Call Admob Get Fuel/Stamina Ads
                             rewardCheck = true;
                         }
                         else
                         {
                             rewardCheck = false;

                         }
                         break;
                     case RewardedAdPlacement.CharacterCarPurchaseRV:
                         if (RemoteConfigManager.instance.CharacterCarPurchaseRV && (AdManager.instance.rewardCheck()))
                         {
                             // Call Admob Character/Car Purchase on RV Ads
                             rewardCheck = true;
                         }
                         else
                         {
                             rewardCheck = false;

                         }
                         break;     
                     case RewardedAdPlacement.ShopItem:
                         if (RemoteConfigManager.instance.ShopItem && (AdManager.instance.rewardCheck()))
                         {
                             // Call Admob Character/Car Purchase on RV Ads
                             rewardCheck = true;
                         }
                         else
                         {
                             rewardCheck = false;

                         }
                         break;
                     default:
                         rewardCheck = false;
                         break;
                 }
             }
             else { Debug.Log("Enable"); rewardCheck = false; }

         }
         else
         {
             rewardCheck = false;
         }

         return rewardCheck;


     }
    */
    public bool RewardChecks(RewardedAdPlacement rewardedAdPlacement)
    {
        bool rewardCheck;
        if (RemoteConfigManager.instance.RewardCheck)
        {

            if (isApplovinAdsEnable && RemoteConfigManager.instance.ShowApplovinRewarded)
            {

                switch (rewardedAdPlacement)
                {
                    case RewardedAdPlacement.ReviveAds:
                        if (RemoteConfigManager.instance.ReviveAds && (ApplovinAdManager.instance.RewardCheckMAX()))
                        {
                            // Call Admob Revive Ads
                            rewardCheck = true;
                        }
                        else
                        {
                            rewardCheck = false;

                        }
                        break;
                    case RewardedAdPlacement.GetCoins:
                        if (RemoteConfigManager.instance.GetCoins && (ApplovinAdManager.instance.RewardCheckMAX()))
                        {
                            // Call Admob Get Coins Ads
                            rewardCheck = true;
                        }
                        else
                        {
                            rewardCheck = false;

                        }
                        break;
                    case RewardedAdPlacement.GetPowerup:
                        if (RemoteConfigManager.instance.GetPowerup && (ApplovinAdManager.instance.RewardCheckMAX()))
                        {
                            // Call Admob Get Powerup Ads
                            rewardCheck = true;
                        }
                        else
                        {
                            rewardCheck = false;

                        }
                        break;
                    case RewardedAdPlacement.GetFuelStamina:
                        if (RemoteConfigManager.instance.GetFuelStamina && (ApplovinAdManager.instance.RewardCheckMAX()))
                        {
                            // Call Admob Get Fuel/Stamina Ads
                            rewardCheck = true;
                        }
                        else
                        {
                            rewardCheck = false;

                        }
                        break;
                    case RewardedAdPlacement.CharacterCarPurchaseRV:
                        if (RemoteConfigManager.instance.CharacterCarPurchaseRV && (ApplovinAdManager.instance.RewardCheckMAX()))
                        {
                            // Call Admob Character/Car Purchase on RV Ads
                            rewardCheck = true;
                        }
                        else
                        {
                            rewardCheck = false;

                        }
                        break;
                    case RewardedAdPlacement.ShopItem:
                        if (RemoteConfigManager.instance.ShopItem && (ApplovinAdManager.instance.RewardCheckMAX()))
                        {
                            // Call Admob Character/Car Purchase on RV Ads
                            rewardCheck = true;
                        }
                        else
                        {
                            rewardCheck = false;

                        }
                        break;
                    default:
                        rewardCheck = false;
                        break;
                }

            }
            else if (isAdmobAdsEnable)
            {
                switch (rewardedAdPlacement)
                {
                    case RewardedAdPlacement.ReviveAds:
                        if (RemoteConfigManager.instance.ReviveAds && (AdManager.instance.rewardCheck()))
                        {
                            // Call Admob Revive Ads
                            rewardCheck = true;
                        }
                        else
                        {
                            rewardCheck = false;

                        }
                        break;
                    case RewardedAdPlacement.GetCoins:
                        if (RemoteConfigManager.instance.GetCoins && (AdManager.instance.rewardCheck()))
                        {
                            // Call Admob Get Coins Ads
                            rewardCheck = true;
                        }
                        else
                        {
                            rewardCheck = false;

                        }
                        break;
                    case RewardedAdPlacement.GetPowerup:
                        if (RemoteConfigManager.instance.GetPowerup && (AdManager.instance.rewardCheck()))
                        {
                            // Call Admob Get Powerup Ads
                            rewardCheck = true;
                        }
                        else
                        {
                            rewardCheck = false;

                        }
                        break;
                    case RewardedAdPlacement.GetFuelStamina:
                        if (RemoteConfigManager.instance.GetFuelStamina && (AdManager.instance.rewardCheck()))
                        {
                            // Call Admob Get Fuel/Stamina Ads
                            rewardCheck = true;
                        }
                        else
                        {
                            rewardCheck = false;

                        }
                        break;
                    case RewardedAdPlacement.CharacterCarPurchaseRV:
                        if (RemoteConfigManager.instance.CharacterCarPurchaseRV && (AdManager.instance.rewardCheck()))
                        {
                            // Call Admob Character/Car Purchase on RV Ads
                            rewardCheck = true;
                        }
                        else
                        {
                            rewardCheck = false;

                        }
                        break;
                    case RewardedAdPlacement.ShopItem:
                        if (RemoteConfigManager.instance.ShopItem && (AdManager.instance.rewardCheck()))
                        {
                            // Call Admob Character/Car Purchase on RV Ads
                            rewardCheck = true;
                        }
                        else
                        {
                            rewardCheck = false;

                        }
                        break;
                    default:
                        rewardCheck = false;
                        break;
                }
            }
            else { Debug.Log("Enable"); rewardCheck = false; }

        }
        else
        {
            rewardCheck = false;
        }

        return rewardCheck;


    }

    public void ShowRewardAd()
    {
        if (isApplovinAdsEnable && RemoteConfigManager.instance.ShowApplovinRewarded)
        {
            ApplovinAdManager.instance.ShowRewardedAd();
        }
        else if (isAdmobAdsEnable)
        {
            AdManager.instance.Show_AdMob_Rewarded();
        }
        else
        {
            Debug.Log("Please Enable ads From Remote Config ");
        }
    }
    public void ShowSquare()
    {
        if (isAdmobAdsEnable)
        {
            if (RemoteConfigManager.instance.SquareBannerCheck)
            {
                if (AdManager.instance)
                {
                    AdManager.instance.Show_AdMob_RectangleBanner();
                }
            }
        }
        else if (isApplovinAdsEnable)
        {

            if (RemoteConfigManager.instance.ApplovinMREC)
            {
                if (RemoteConfigManager.instance.SquareBannerCheck)
                {
                    if (AdManager.instance)
                    {
                        AdManager.instance.ShowApplovinMREC();
                    }
                }
            }
        }
        else
        {
            Debug.Log("Please Enable Ads from Remote Config");
        }

    }
    public void HideSquare()
    {
        if (isAdmobAdsEnable)
        {
            if (AdManager.instance)
            {
                AdManager.instance.Hide_AdMob_RectangleBanner();
            }
        }
        else
        {
            if (AdManager.instance)
            {
                AdManager.instance.HideApplovinMREC();
            }
        }

    }

}
