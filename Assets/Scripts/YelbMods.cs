// DecompilerFi decompiler from Assembly-CSharp.dll class: YelbMods
using System.Collections.Generic;
using UnityEngine;

public class YelbMods : MonoBehaviour
{
	[Header("List")]
	internal List<GameObject> modsHighDone = new List<GameObject>();

	[Header("Prefabes")]
	public GameObject BoxSmall;

	public GameObject BoxLarg;

	private void Update()
	{
		foreach (GameObject item in modsHighDone)
		{
			if (item != null)
			{
				SetHigh(item, Up: false);
			}
		}
	}

	public void SetHigh(GameObject Model, bool Up)
	{
		if (!modsHighDone.Contains(Model))
		{
			modsHighDone.Add(Model);
		}
		Color c = Color.white / 3f;
		if (!Up)
		{
			c = Color.black;
		}
		if (Up && Model.transform.childCount > 0 && Model.transform.GetChild(0).name == "CloseStatus")
		{
			c = Color.red;
		}
		MeshRenderer[] componentsInChildren = Model.GetComponentsInChildren<MeshRenderer>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			Material[] materials = componentsInChildren[i].materials;
			foreach (Material obj in materials)
			{
				Color value = Vector4.Lerp(obj.GetColor("_EmissionColor"), c, 0.3f);
				obj.EnableKeyword("_EMISSION");
				obj.globalIlluminationFlags = MaterialGlobalIlluminationFlags.EmissiveIsBlack;
				obj.SetColor("_EmissionColor", value);
			}
		}
	}
}
