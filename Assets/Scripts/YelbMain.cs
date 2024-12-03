// DecompilerFi decompiler from Assembly-CSharp.dll class: YelbMain
using UnityEngine;
using Yelbouziani;
using Yelbouziani.Enum;

public class YelbMain : MonoBehaviour
{
	public void StartGame()
	{
		YelbBackend.LoadSceneMode(SceneLoadMode.next);
	}
}
