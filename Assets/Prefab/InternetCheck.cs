using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InternetCheck : MonoBehaviour
{

    public GameObject panel;
    void Start()
    {
        
    }

    void Update()
    {
        if (Application.internetReachability == NetworkReachability.NotReachable)
        {
            panel.SetActive(true);
        }
        else
        {
            panel.SetActive(false);
        }
    }
}
