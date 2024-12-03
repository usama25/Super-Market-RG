// DecompilerFi decompiler from Assembly-CSharp.dll class: YelbUI
using System.Collections;
using UnityEngine;

public class YelbUI : MonoBehaviour
{
	public GameObject PanelLoginName;

	public GameObject PanelComputer;

	public GameObject PanelSettings;

	public GameObject PanelTutorial0;

	public GameObject PanelTutorial1;

	public GameObject PanelTutorial2;

	public GameObject PanelGhost;

	public GameObject PanelColorize;

	public GameObject PanelPrices;

	public GameObject PanelController;

	public GameObject PanelJoystick;

	public void SetTutorialFirstTime(bool Mode)
	{
		if (Mode)
		{
			PanelTutorial0.SetActive(value: true);
			StartCoroutine(LoadingAction());
		}
		else
		{
			PanelTutorial1.SetActive(value: true);
		}
	}

	private IEnumerator LoadingAction()
	{
		yield return new WaitForSeconds(2f);
		PanelTutorial0.SetActive(value: false);
		PanelTutorial1.SetActive(value: true);
	}
}
