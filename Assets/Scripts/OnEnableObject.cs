using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OnEnableObject : MonoBehaviour
{
    public YelbMain yelbMain;
    void OnEnable()
    {
         if (AppLovinAndAdmobManager.instance)                          		AppLovinAndAdmobManager.instance.ShowInterstitial(AppLovinAndAdmobManager.InterstitialAdPlacement.Play);
        
StartCoroutine(SceneLoader());
    }

    IEnumerator SceneLoader()
    {
        yield return new WaitForSeconds(7);
        yelbMain.StartGame();
    }
}
