// DecompilerFi decompiler from Assembly-CSharp.dll class: Dumpset
using System.Collections;
using UnityEngine;

public class Dumpset : MonoBehaviour
{
	[Header("Transform")]
	public Transform[] BodyCap;

	[Header("Quater")]
	internal Quaternion ClosedRotation;

	[Header("Boolean Manager")]
	internal bool IsBussy;

	private void Start()
	{
		ClosedRotation = BodyCap[0].rotation;
		ClosedRotation = BodyCap[1].rotation;
	}

	public void OpenBox(bool Status)
	{
		if (!Status || !IsBussy)
		{
			if (!Status && IsBussy)
			{
				StopAllCoroutines();
			}
			if (Status)
			{
				StartCoroutine(LoadingAction(Status: true));
			}
			if (!Status)
			{
				StartCoroutine(LoadingAction(Status: false));
			}
			if (Status && !IsBussy)
			{
				IsBussy = true;
			}
		}
	}

	private IEnumerator LoadingAction(bool Status)
	{
		yield return new WaitForEndOfFrame();
		if (Status)
		{
			Transform[] bodyCap = BodyCap;
			for (int i = 0; i < bodyCap.Length; i++)
			{
				bodyCap[i].GetComponent<Animator>().Play("OpenLid");
			}
		}
		if (!Status)
		{
			Transform[] bodyCap = BodyCap;
			for (int i = 0; i < bodyCap.Length; i++)
			{
				bodyCap[i].GetComponent<Animator>().Play("CloseLid01");
			}
		}
		IsBussy = false;
	}
}
