// DecompilerFi decompiler from Assembly-CSharp.dll class: YelbAudioManager
using UnityEngine;
using UnityEngine.UI;

public class YelbAudioManager : MonoBehaviour
{
	public AudioSource[] SoundCash;

	public AudioSource[] SoundEarn;

	public AudioSource[] SoundItemPut;

	public AudioSource[] SoundBigBox;

	public AudioSource ClickSound;

	private void Start()
	{
		Button[] array = UnityEngine.Object.FindObjectsOfType<Button>(includeInactive: true);
		for (int i = 0; i < array.Length; i++)
		{
			array[i].onClick.AddListener(delegate
			{
				ClickSound.Play();
			});
		}
	}

	public void StartCash()
	{
		SoundPlay(SoundCash);
	}

	public void EarnCash()
	{
		SoundPlay(SoundEarn);
	}

	public void StartItemPut()
	{
		SoundPlay(SoundItemPut);
	}

	public void StartBigBox()
	{
		SoundPlay(SoundBigBox);
	}

	public void SoundPlay(AudioSource[] SD)
	{
		SD[Random.Range(0, SD.Length)].Play();
	}
}
