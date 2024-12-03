// DecompilerFi decompiler from Assembly-CSharp.dll class: YelbLoading
using System.Collections;
using UnityEngine;
using Yelbouziani;
using Yelbouziani.Enum;

public class YelbLoading : MonoBehaviour
{
	private void Start()
	{
		StartCoroutine(LoadingAction());
	}

	private IEnumerator LoadingAction()
	{
		yield return new WaitForSeconds(3f);
		YelbBackend.LoadSceneMode(SceneLoadMode.target, 2);
	}
}
