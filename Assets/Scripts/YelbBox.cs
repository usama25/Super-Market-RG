// DecompilerFi decompiler from Assembly-CSharp.dll class: YelbBox
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class YelbBox : MonoBehaviour
{
	[Header("Manager")]
	internal YelbController _Controller;

	internal Dumpset _Dumpset;

	[Header("Transform")]
	public Transform[] Slots;

	public Transform InteractedOBJ;

	public Transform GhostOBJ;

	[Header("OBJ")]
	public GameObject InterractiveBox;

	public GameObject RenderObject;

	public GameObject ExplosionEffect;

	[Header("List")]
	public List<Transform> Items = new List<Transform>();

	[Header("Boolean Manager")]
	internal bool BoxInUse;

	internal bool BoxBigInislized;

	internal bool PlaceOBJECT;

	internal bool IsTranscripted = true;

	internal bool IsDestroyed = true;

	internal bool IsAdded;

	[Header("strings")]
	internal string ItemName = "";

	[Header("Sprites")]
	internal Sprite IconItem;

	[Header("Renders")]
	internal MeshRenderer[] Renders;

	[Header("Animation")]
	internal Animation _Anim;

	[Header("Vectors")]
	internal Vector3 OriginalScale = Vector3.zero;

	internal Vector3 PosAfterMoveTo = new Vector3(15,0,8);

	internal Vector3 VelocityInteract = Vector3.zero;

	internal Vector3 RotationAxis = Vector3.zero;

	internal Vector3 PosToMoveInsideBig = Vector3.zero;

	internal Vector3 PositionMe = Vector3.zero;

	internal Vector3 RotationMe = Vector3.zero;

	[Header("String ID")]
	public string IDInformation = "";

	[Header("Integer Controller")]
	internal int CountItems;

	internal int IsUsed;

	[Header("Floating")]
	internal float TimeToCheck = 0.2f;

	internal float PriceItem;

	private void Awake()
	{
		_Controller = UnityEngine.Object.FindObjectOfType<YelbController>();
		_Dumpset = UnityEngine.Object.FindObjectOfType<Dumpset>();
	}

	private void Start()
	{
		OriginalScale = base.transform.localScale;
		_Anim = GetComponent<Animation>();
		if (Items.Count > 0)
		{
			Items[0].gameObject.SetActive(value: false);
		}
		base.gameObject.AddComponent<NavMeshObstacle>();
		base.gameObject.GetComponent<NavMeshObstacle>().size = GetComponentInChildren<BoxCollider>().size;
		base.gameObject.GetComponent<NavMeshObstacle>().carving = true;
	}

	private void LateUpdate()
	{
		IDInformation = base.name + "/" + ItemName + "/" + IconItem.name + "/" + IsUsed.ToString() + "/" + CountItems.ToString() + "/" + base.transform.position.ToString() + "/" + base.transform.eulerAngles.ToString();
		if (TimeToCheck > 0f)
		{
			TimeToCheck -= Time.deltaTime;
		}
		else if (!IsAdded)
		{
			_Controller.AddDataObject(IDInformation);
			_Controller.SaveDataObject(base.gameObject, IconItem.name, ItemName, CountItems, IDInformation, base.transform.position, base.transform.eulerAngles, STMode: true);
			IsAdded = true;
		}
		else if ((PositionMe != base.transform.position || RotationMe != base.transform.eulerAngles) && !BoxInUse)
		{
			_Controller.SaveDataObject(base.gameObject, IconItem.name, ItemName, CountItems, IDInformation, base.transform.position, base.transform.eulerAngles, STMode: true);
			PositionMe = base.transform.position;
			RotationMe = base.transform.eulerAngles;
		}
	}

	public void CleanObject()
	{
		_Controller.RemoveObject(IDInformation);
		List<string> information = new List<string>
		{
			ItemName + " HAS REMOVED"
		};
		_Controller.SpawnNotification(information, null);
		if (GhostOBJ != null)
		{
			UnityEngine.Object.Destroy(GhostOBJ.gameObject);
		}
		UnityEngine.Object.Destroy(base.gameObject);
	}

	public void SpawnBigObject(Vector3 moveTo = default(Vector3))
	{
		PlaceOBJECT = true;
		IsUsed = 1;
		//Items[0].transform.eulerAngles = GhostOBJ.transform.eulerAngles;
		//Items[0].transform.position = PosToMoveInsideBig;
		Items[0].transform.position = moveTo;
		Items[0].transform.localScale = new Vector3(1.4f, 1.38f, 1.35f);
		Items[0].transform.parent = null;
		Items[0].GetComponentInChildren<Collider>().enabled = true;
		Items[0].gameObject.layer = 11;
		YelbReference[] array = UnityEngine.Object.FindObjectsOfType<YelbReference>();
		List<YelbReference> list = new List<YelbReference>();
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i].IconItem == IconItem)
			{
				list.Add(array[i]);
			}
		}
		Items[0].GetComponent<YelbReference>().IDIInformation = Items[0].name + "/" + ItemName + "/" + IconItem.name + "/" + IsUsed.ToString() + "/" + list.Count.ToString() + "/" + base.transform.position.ToString() + "/" + base.transform.eulerAngles.ToString();
		Items[0].GetComponent<YelbReference>().ItemName = ItemName;
		Items[0].GetComponent<YelbReference>().IsUsed = IsUsed;
		Items[0].GetComponent<YelbReference>().CountItems = list.Count;
		Items[0].GetComponent<YelbReference>().IconItem = IconItem;
		Items[0].gameObject.SetActive(value: true);
		Object.FindObjectOfType<YelbAudioManager>().StartBigBox();
		_Controller.RemoveObject(IDInformation);
		//UnityEngine.Object.Destroy(GhostOBJ.gameObject);
		UnityEngine.Object.Destroy(base.gameObject);
	}

	public void DisactivateChild()
	{
		Transform[] componentsInChildren = base.transform.GetComponentsInChildren<Transform>();
		foreach (Transform transform in componentsInChildren)
		{
			if (transform != base.transform)
			{
				transform.gameObject.SetActive(value: false);
			}
		}
	}

	public void StartHoldBoxBig(Vector3 Pos, bool IsActive)
	{
		Debug.Log("Start holding box");
		BoxInUse = IsActive;
		if (PlaceOBJECT)
		{
			return;
		}
		DisactivateChild();
		GetComponent<Rigidbody>().isKinematic = true;
		GetComponent<Collider>().enabled = false;
		if (GhostOBJ == null)
		{
			RenderObject.gameObject.SetActive(value: false);
			Transform transform = UnityEngine.Object.Instantiate(Items[0].GetComponent<YelbReference>().Interactable.gameObject).transform;
			Renders = transform.GetComponentsInChildren<MeshRenderer>();
			GhostOBJ = transform;
			return;
		}
		PosToMoveInsideBig = Pos;
		Pos.y = 0.2420732f;
		if (IsActive)
		{
			GhostOBJ.transform.position = Pos;
			GhostOBJ.transform.eulerAngles = RotationAxis;
			GhostOBJ.gameObject.SetActive(value: true);
			Collider component = GhostOBJ.GetComponent<Collider>();
			component.enabled = true;
			if (GhostOBJ.GetComponent<BoxCollider>() != null)
			{
				GhostOBJ.GetComponent<BoxCollider>().center = new Vector3(GhostOBJ.GetComponent<BoxCollider>().center.x, 0f, GhostOBJ.GetComponent<BoxCollider>().center.z);
			}
			Collider[] array = Physics.OverlapBox(component.bounds.center, component.bounds.extents, Quaternion.identity);
			bool flag = false;
			Collider[] array2 = array;
			foreach (Collider collider in array2)
			{
				if (collider != component)
				{
					string text = collider.name.ToLower();
					if (text.Contains("door") || text.Contains("wall") || text.Contains("road") || text.Contains("triggertrash") || text.Contains("boxdestroyer"))
					{
						flag = true;
					}
				}
			}
			if (IsTranscripted && flag)
			{
				MeshRenderer[] renders = Renders;
				foreach (MeshRenderer obj in renders)
				{
					obj.material.SetColor("_Color", UnityEngine.Object.FindObjectOfType<YelbController>().WrongColor);
					obj.material.color = UnityEngine.Object.FindObjectOfType<YelbController>().WrongColor;
				}
				Object.FindObjectOfType<YelbLinker>().PlaceBtn.interactable = false;
				IsTranscripted = false;
			}
			if (!IsTranscripted && !flag)
			{
				MeshRenderer[] renders = Renders;
				foreach (MeshRenderer obj2 in renders)
				{
					obj2.material.SetColor("_Color", UnityEngine.Object.FindObjectOfType<YelbController>().NormalColor);
					obj2.material.color = UnityEngine.Object.FindObjectOfType<YelbController>().NormalColor;
				}
				Object.FindObjectOfType<YelbLinker>().PlaceBtn.interactable = true;
				IsTranscripted = true;
			}
		}
		if (!IsActive)
		{
			GhostOBJ.gameObject.SetActive(value: false);
			Object.FindObjectOfType<YelbLinker>().PlaceBtn.interactable = false;
		}
	}

	public void ActivateBigOutline(bool Status)
	{
		Transform[] componentsInChildren = base.transform.GetComponentsInChildren<Transform>(includeInactive: true);
		Transform[] array;
		if (Status)
		{
			array = componentsInChildren;
			foreach (Transform transform in array)
			{
				if (transform != base.transform)
				{
					transform.gameObject.layer = 21;
				}
			}
		}
		if (Status)
		{
			return;
		}
		array = componentsInChildren;
		foreach (Transform transform2 in array)
		{
			if (transform2 != base.transform)
			{
				transform2.gameObject.layer = 0;
			}
		}
	}

	public void SetOutline(bool Status)
	{
		ActivateBigOutline(Status);
	}

	public void SetHide()
	{
		if (InteractedOBJ != null)
		{
			InteractedOBJ.gameObject.SetActive(value: false);
		}
	}

	public void SetPosLocated(Vector3 Location, float FixedPositionY)
	{
		if (InteractedOBJ == null)
		{
			InteractedOBJ = UnityEngine.Object.Instantiate(InterractiveBox).transform;
		}
		SetOutline(Status: false);
		PosAfterMoveTo = Location;
		InteractedOBJ.gameObject.SetActive(value: true);
		InteractedOBJ.position = Vector3.SmoothDamp(InteractedOBJ.position, new Vector3(PosAfterMoveTo.x, FixedPositionY, PosAfterMoveTo.z), ref VelocityInteract, 0.1f);
	}

	public void IsOnUses(bool mode, Transform Holder)
	{
		BoxInUse = mode;
		if (mode)
		{
			_Anim.clip = _Anim.GetClip("Open");
			_Anim.Play();
			GetComponent<Rigidbody>().isKinematic = true;
			GetComponent<Collider>().enabled = false;
			base.transform.SetParent(Holder);
			base.transform.localScale = Vector3.one;
			base.transform.localRotation = Quaternion.identity;
			base.transform.localPosition = Vector3.zero;
			Object.FindObjectOfType<YelbCharacter>().BoxHolding = this;
			Object.FindObjectOfType<BooleanManager>().IsHoldingBox = true;
		}
		if (!mode)
		{
			StartCoroutine(LoadingAction());
		}
	}

	private IEnumerator LoadingAction()
	{
		_Anim.clip = _Anim.GetClip("Close");
		_Anim.Play();
		yield return new WaitForSeconds(1f);
		Object.FindObjectOfType<BooleanManager>().IsHoldingBox = false;
		Object.FindObjectOfType<YelbCharacter>().BoxHolding = null;
		InteractedOBJ.gameObject.SetActive(value: false);
		base.transform.SetParent(null);
		base.transform.localScale = OriginalScale;
		base.transform.position = PosAfterMoveTo + new Vector3(0f, 1f, 0f);
		base.transform.rotation = InteractedOBJ.rotation;
		GameObject gameObject = UnityEngine.Object.Instantiate(ExplosionEffect);
		gameObject.transform.position = base.transform.position;
		UnityEngine.Object.Destroy(gameObject, 3f);
		GameObject.Find("StoneImpactFround").GetComponent<AudioSource>().Play();
		GetComponent<Collider>().enabled = true;
		GetComponent<Rigidbody>().isKinematic = false;
		GetComponent<Rigidbody>().velocity = Vector3.zero;
		_Anim.clip = _Anim.GetClip("Close");
		_Anim.Play();
	}

	private IEnumerator ClearTime()
	{
		yield return new WaitForSeconds(0.2f);
		GameObject.Find("etfx_explosion_laserTrash").GetComponent<AudioSource>().Play();
		while (!_Dumpset.IsBussy)
		{
			yield return null;
		}
		CleanObject();
	}

	private void OnTriggerStay(Collider other)
	{
		if (other.name == "BoxDestroyer")
		{
			if (IsDestroyed)
			{
				StartCoroutine(ClearTime());
			}
			IsDestroyed = false;
		}
	}
}
