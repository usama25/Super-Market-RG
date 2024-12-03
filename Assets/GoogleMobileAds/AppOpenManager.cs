using GoogleMobileAds.Api;
using GoogleMobileAds.Common;
using UnityEngine;

namespace GoogleMobileAds
{
    public class AppOpenManager : MonoBehaviour
    {
        private static AppOpenManager _appOpenManager;

        // Ensures only one instance of AppOpenManager exists throughout the game
        private void Awake()
        {
            if (_appOpenManager == null)
            {
                _appOpenManager = this;
                DontDestroyOnLoad(gameObject);
            }
            else
            {
                Destroy(gameObject);
            }
        }

        private void Start()
        {
            AppStateEventNotifier.AppStateChanged += OnAppStateChanged;
        }

        private void OnDestroy()
        {
            AppStateEventNotifier.AppStateChanged -= OnAppStateChanged;
        }

        private void OnAppStateChanged(AppState state)
        {
            if (state == AppState.Foreground)
            {
                if (!AdManager.instance) return;
                if (AdManager.instance.Google_Ads_Manager._appOpenAd != null)
                {
                    AdManager.instance.ShowAppOpenAd();
                }
            }
        }
    }
}