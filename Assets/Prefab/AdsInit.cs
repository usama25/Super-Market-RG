using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AdsInit : MonoBehaviour
{

    public static AdsInit instance;

    void Start()
    {
        if (instance == null)
            instance = this;
        else
            Destroy(this.gameObject);
      //  Advertisements.Instance.SetUserConsent(true);
      //  Advertisements.Instance.Initialize();
    }

    
    void Update()
    {
        
    }
}
