using GoogleMobileAds.Api;
using GoogleMobileAds.Ump.Api;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class UMP : MonoBehaviour
{
    private bool consentObtained = false;
    private bool consentFormShown = false;

    void Start()
    {
        //ConsentInformation.Reset();
        var debugSettings = new ConsentDebugSettings
        {
            DebugGeography = DebugGeography.EEA,
            TestDeviceHashedIds = new List<string>
            {
                "903D93C064F5D393AC6CA51219A09CB7",
                "75EF8D155528C04DACBBA6F36F433035",
                "f5efc7c3-1677-4c1d-8557-c3d5ad5d6898",
                "f5efc7c316774c1d8557c3d5ad5d6898",
                "78612386D15FC0CB0E10CDE1DBAA0150",
                "a3799a04-0018-4360-9c10-679d5adb79e7",
                "a3799a04001843609c10679d5adb79e7",
            },
        };

        ConsentRequestParameters request = new ConsentRequestParameters
        {
            ConsentDebugSettings = debugSettings,
        };

        ConsentInformation.Update(request, OnConsentInfoUpdated);
    }

    void OnConsentInfoUpdated(FormError consentError)
    {
        if (consentError != null)
        {
            Debug.LogError(consentError);
            return;
        }

        // Consent information state was updated.
        if (!consentFormShown)
        {
            ConsentForm.LoadAndShowConsentFormIfRequired((FormError formError) =>
            {
                if (formError != null)
                {
                    Debug.LogError(formError);
                    return;
                }

                // Consent has been gathered.
                consentObtained = true;
                if (ConsentInformation.CanRequestAds())
                {
                    if (consentObtained)
                    {
                       // SceneManager.LoadScene("Splash");
                       
                    }
                }
            });

            consentFormShown = true; // Set the flag to true to prevent multiple instantiations
        }
    }
}
