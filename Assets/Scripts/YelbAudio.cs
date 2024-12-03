// DecompilerFi decompiler from Assembly-CSharp.dll class: YelbAudio
using UnityEngine;
using UnityEngine.UI;
using Yelbouziani;
using Yelbouziani.Enum;

public class YelbAudio : MonoBehaviour
{
	[Header("Sources")]
	public AudioSource MusicBg;

	public AudioSource SoundClick;

	private void Start()
	{
		MusicBg.Play();
		Button[] array = UnityEngine.Object.FindObjectsOfType<Button>(includeInactive: true);
		for (int i = 0; i < array.Length; i++)
		{
			array[i].onClick.AddListener(delegate
			{
				SoundClick.Play();
			});
		}
	}

	private void LateUpdate()
	{
		float volume = YelbBackend.GetVolume(VolumeMode.sound);
		float volume2 = YelbBackend.GetVolume(VolumeMode.music);
		YelbBackend.GetVolume(VolumeMode.music);
		MusicBg.volume = volume2;
		SoundClick.volume = volume;
	}
}
