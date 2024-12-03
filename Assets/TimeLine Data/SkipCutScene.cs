using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SkipCutScene : MonoBehaviour
{
    public void SkipCutSceneFunction()
    {
        SceneManager.LoadScene("GamePlay");
    }
}
