// DecompilerFi decompiler from Assembly-CSharp.dll class: YelbCustomColor
using UnityEngine;
using UnityEngine.UI;

public class YelbCustomColor : MonoBehaviour
{
	public Slider ValueR;

	public Slider ValueG;

	public Slider ValueB;

	[Header("Panels")]
	public GameObject PlayerPanel;

	public GameObject ComputePanel;

	public GameObject WorkCustomizePanel;

	[Header("Mesh Renders")]
	public MeshRenderer[] Renders;

	private void LateUpdate()
	{
		SetModeColor();
	}

	public void SetModeColor()
	{
		if (!base.gameObject.activeSelf)
		{
			ValueB.GetComponent<SliderMods>().Init();
			ValueG.GetComponent<SliderMods>().Init();
			ValueB.GetComponent<SliderMods>().Init();
		}
		MeshRenderer[] renders = Renders;
		foreach (MeshRenderer meshRenderer in renders)
		{
			if (meshRenderer.materials.Length > 1)
			{
				meshRenderer.materials[1].SetColor("_Color", new Color(ValueR.value, ValueG.value, ValueB.value, 1f));
				meshRenderer.materials[1].color = new Color(ValueR.value, ValueG.value, ValueB.value, 1f);
			}
			else
			{
				meshRenderer.material.SetColor("_Color", new Color(ValueR.value, ValueG.value, ValueB.value, 1f));
				meshRenderer.material.color = new Color(ValueR.value, ValueG.value, ValueB.value, 1f);
			}
		}
	}

	public void BackOriginal()
	{
		PlayerPanel.SetActive(value: true);
		ComputePanel.SetActive(value: true);
		WorkCustomizePanel.SetActive(value: true);
		base.gameObject.SetActive(value: false);
	}
}
