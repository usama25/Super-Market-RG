using GoogleMobileAds.Ump.Api;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShowAds : MonoBehaviour
{


    




    public void ShowBanner()
    {
        if (AppLovinAndAdmobManager.instance)
        {
            AppLovinAndAdmobManager.instance.ShowBanner();
        }
    }

    public void ShowIntertital()
    {
        
        if (AppLovinAndAdmobManager.instance)
        {
            AppLovinAndAdmobManager.instance.ShowInterstitial(AppLovinAndAdmobManager.InterstitialAdPlacement.Play);
        }

    }
    public void ShowSquare()

    {
        //AppLovinAndAdmobManager.instance.ShowSquare();
        AppLovinAndAdmobManager.instance.ShowSquare();

    }  
    public void HideSquare()
    {
        AppLovinAndAdmobManager.instance.HideSquare();
    }
    public void ShowRewarded()
    {
        AppLovinAndAdmobManager.instance.ShowRewardAd();



        if (AppLovinAndAdmobManager.instance)
        {
            if (AppLovinAndAdmobManager.instance.RewardChecks(AppLovinAndAdmobManager.RewardedAdPlacement.CharacterCarPurchaseRV))
            {

                //Here you can also check if rewarded Ad Available then show Rewarded Ad button
                //If rewarded Add available then show button call below function


                AppLovinAndAdmobManager.instance.ShowRewardAd();
            }
        }

    }
}
