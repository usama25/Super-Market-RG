using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class CutSceneEnd : MonoBehaviour
{
    public void ChangeScene()
    {
        SceneManager.LoadScene("GamePlay");
    }
}
