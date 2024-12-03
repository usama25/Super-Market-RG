// DecompilerFi decompiler from Assembly-CSharp.dll class: ComputerButtons
using UnityEngine;
using UnityEngine.UI;

public class ComputerButtons : MonoBehaviour
{
	[Header("Manager")]
	public ComputerController ControllerCOMP;

	[Header("Transform")]
	public Transform ScroolView;

	public Transform ContentContainer;

	[Header("List Items")]
	public ShopItem[] Items;

	public void TakeController()
	{
		GetComponent<Button>().onClick.AddListener(delegate
		{
			ControllerCOMP.SpawnList(ScroolView, ContentContainer, ContentContainer.GetChild(0).gameObject, Items, this);
		});
	}
}
