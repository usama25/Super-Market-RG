// DecompilerFi decompiler from Assembly-CSharp.dll class: Yelbouziani.Helper.Scrolling
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;
using Yelbouziani.Enum;

namespace Yelbouziani.Helper
{
	public class Scrolling : MonoBehaviour, IPointerMoveHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler
	{
		[Header("UI")]
		public Button Left;

		public Button Right;

		[Header("Transform")]
		private Transform ContentContainer;

		[Header("Manager")]
		public TypeScroll Mode;

		[Header("Boolean Manager")]
		private bool PointerDown;

		private bool StartChecking;

		[Header("Vectors")]
		private Vector3 NormalScale = new Vector3(1f, 1f, 1f);

		private Vector3 MineScale = new Vector3(0.7f, 0.7f, 0.7f);

		private Vector2 StartMove = Vector2.zero;

		[Header("Integer")]
		internal int CenterChild;

		[Header("Floating")]
		public float Offset = 79.8f;

		private void Start()
		{
			StartCoroutine(WaitingAction());
		}

		private void OnEnable()
		{
			StartCoroutine(WaitingAction());
		}

		private IEnumerator WaitingAction()
		{
			yield return new WaitForEndOfFrame();
			CheckingInisilize();
		}

		private void CheckingInisilize()
		{
			Left.gameObject.SetActive(value: true);
			Left.onClick.RemoveAllListeners();
			Right.gameObject.SetActive(value: true);
			Right.onClick.RemoveAllListeners();
			if (base.transform.childCount == 1)
			{
				Left.gameObject.SetActive(value: false);
				Right.gameObject.SetActive(value: false);
			}
			if (base.transform.childCount == 2)
			{
				Left.gameObject.SetActive(value: false);
			}
			ContentContainer = base.transform;
			if (Mode == TypeScroll.buttons)
			{
				Left.onClick.AddListener(ClickLeft);
				Right.onClick.AddListener(ClickRight);
			}
			if (Mode == TypeScroll.gesture)
			{
				Image image = GetComponent<Image>();
				if (image == null)
				{
					image = base.gameObject.AddComponent<Image>();
				}
				Color white = Color.white;
				white.a = 0f;
				image.color = white;
			}
		}

		private void ClickLeft()
		{
			if (CenterChild > 0)
			{
				Right.gameObject.SetActive(value: true);
				CenterChild--;
			}
			if (CenterChild < 1)
			{
				Left.gameObject.SetActive(value: false);
			}
		}

		private void ClickRight()
		{
			if (CenterChild < ContentContainer.childCount - 1)
			{
				Left.gameObject.SetActive(value: true);
				CenterChild++;
			}
			if (CenterChild > ContentContainer.childCount - 2)
			{
				Right.gameObject.SetActive(value: false);
			}
		}

		private void Update()
		{
			if (ContentContainer != null && ContentContainer.childCount > 0 && !StartChecking)
			{
				CenterChild = 0;
				StartChecking = true;
			}
			if (!StartChecking)
			{
				return;
			}
			List<Transform> list = new List<Transform>();
			for (int i = 0; i < ContentContainer.childCount; i++)
			{
				list.Add(ContentContainer.GetChild(i));
			}
			float centerPositionX = GetComponent<RectTransform>().rect.width / 2f + Offset;
			float rightPositionX = GetComponent<RectTransform>().rect.width + Offset;
			if (PointerDown || list.Count <= 0)
			{
				return;
			}
			for (int j = 0; j < list.Count; j++)
			{
				if ((j < CenterChild - 1 && j != CenterChild) || (j > CenterChild + 1 && j != CenterChild))
				{
					list[j].localScale = Vector3.zero;
				}
			}
			Transform leftChild = (CenterChild > 0) ? list[CenterChild - 1] : null;
			Transform rightChild = (CenterChild < list.Count - 1) ? list[CenterChild + 1] : null;
			ApplyScaleChild(leftChild, rightChild, rightPositionX);
			ApplyScaleCenter(list[CenterChild], centerPositionX);
		}

		private void ApplyScaleChild(Transform leftChild, Transform rightChild, float rightPositionX)
		{
			if (leftChild != null)
			{
				if (leftChild.localScale.x < MineScale.x)
				{
					leftChild.localScale = MineScale;
					leftChild.GetComponent<RectTransform>().anchoredPosition = new Vector2(0f - Offset, leftChild.GetComponent<RectTransform>().anchoredPosition.y);
				}
				leftChild.localScale = SmoothScaleChange(leftChild.localScale, MineScale);
				leftChild.GetComponent<RectTransform>().anchoredPosition = SmoothPositionChange(leftChild.GetComponent<RectTransform>().anchoredPosition, new Vector2(Offset, leftChild.GetComponent<RectTransform>().anchoredPosition.y));
			}
			if (rightChild != null)
			{
				if (rightChild.localScale.x < MineScale.x)
				{
					rightChild.localScale = MineScale;
					rightChild.GetComponent<RectTransform>().anchoredPosition = new Vector2(rightPositionX + Offset * 5f, rightChild.GetComponent<RectTransform>().anchoredPosition.y);
				}
				rightChild.localScale = SmoothScaleChange(rightChild.localScale, MineScale);
				rightChild.GetComponent<RectTransform>().anchoredPosition = SmoothPositionChange(rightChild.GetComponent<RectTransform>().anchoredPosition, new Vector2(rightPositionX, rightChild.GetComponent<RectTransform>().anchoredPosition.y));
			}
		}

		private void ApplyScaleCenter(Transform center, float centerPositionX)
		{
			center.localScale = SmoothScaleChange(center.localScale, NormalScale);
			center.GetComponent<RectTransform>().anchoredPosition = SmoothPositionChange(center.GetComponent<RectTransform>().anchoredPosition, new Vector2(centerPositionX, center.GetComponent<RectTransform>().anchoredPosition.y));
		}

		private Vector2 SmoothPositionChange(Vector2 currentPosition, Vector2 targetPosition)
		{
			float t = 10f * Time.deltaTime;
			return Vector2.Lerp(currentPosition, targetPosition, t);
		}

		private Vector3 SmoothScaleChange(Vector3 currentScale, Vector3 targetScale)
		{
			float maxDistanceDelta = 2f * Time.deltaTime;
			return Vector3.MoveTowards(currentScale, targetScale, maxDistanceDelta);
		}

		public void OnPointerMove(PointerEventData eventData)
		{
			if (Mode == TypeScroll.gesture && PointerDown)
			{
				Vector2 startMove = StartMove;
				Vector2 position = eventData.position;
				if (StartMove != eventData.position)
				{
					float x = StartMove.x;
					float x2 = eventData.position.x;
					float x3 = StartMove.x;
					float x4 = eventData.position.x;
				}
			}
		}

		public void OnPointerDown(PointerEventData eventData)
		{
			if (Mode == TypeScroll.gesture)
			{
				StartMove = eventData.position;
				PointerDown = true;
			}
		}

		public void OnPointerUp(PointerEventData eventData)
		{
			if (Mode != TypeScroll.gesture)
			{
				return;
			}
			PointerDown = false;
			if (StartMove != eventData.position)
			{
				if (StartMove.x > eventData.position.x)
				{
					ClickRight();
				}
				if (StartMove.x < eventData.position.x)
				{
					ClickLeft();
				}
			}
		}
	}
}
