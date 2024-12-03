// DecompilerFi decompiler from Assembly-CSharp.dll class: Yelbouziani.Helper.YelbVolumeData
using UnityEngine;
using UnityEngine.UI;
using Yelbouziani.Enum;

namespace Yelbouziani.Helper
{
	public class YelbVolumeData : MonoBehaviour
	{
		[Header("UI")]
		public Sprite ActiveIcon;

		public Sprite InactiveIcon;

		[Header("Mode")]
		public VolumeMode Mode;

		[Header("Boolean Manager")]
		internal float ModeTake;

		private void Start()
		{
			ModeTake = YelbBackend.GetVolume(Mode);
			YelbBackend.ChangeSpriteModeFromFloat(ActiveIcon, InactiveIcon, base.transform.GetChild(0).GetComponent<Image>(), ModeTake);
			Button button = GetComponent<Button>();
			if (button == null)
			{
				button = base.gameObject.AddComponent<Button>();
			}
			button.onClick.AddListener(TakeAction);
		}

		private void TakeAction()
		{
			if (ModeTake == 0f)
			{
				YelbBackend.SetVolume(1f, Mode);
				YelbBackend.ChangeSpriteModeFromFloat(ActiveIcon, InactiveIcon, base.transform.GetChild(0).GetComponent<Image>(), YelbBackend.GetVolume(Mode));
				ModeTake = 1f;
			}
			else if (ModeTake == 1f)
			{
				YelbBackend.SetVolume(0f, Mode);
				YelbBackend.ChangeSpriteModeFromFloat(ActiveIcon, InactiveIcon, base.transform.GetChild(0).GetComponent<Image>(), YelbBackend.GetVolume(Mode));
				ModeTake = 0f;
			}
		}
	}
}
