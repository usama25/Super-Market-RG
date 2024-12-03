// DecompilerFi decompiler from Assembly-CSharp.dll class: CashPositionIndex
using System.Collections.Generic;
using UnityEngine;

public class CashPositionIndex : MonoBehaviour
{
	public List<GameObject> ListNPC = new List<GameObject>();

	private void LateUpdate()
	{
		ListNPC.RemoveAll((GameObject item) => item == null);
	}
}
