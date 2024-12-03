// DecompilerFi decompiler from Assembly-CSharp.dll class: YelbReference
using UnityEngine;
using UnityEngine.AI;

public class YelbReference : MonoBehaviour
{
	[Header("Manager")]
	internal YelbController _Controller;

	[Header("Objects")]
	public GameObject Interactable;

	[Header("Transform")]
	internal Transform MovingGhost;

	[Header("Vectors")]
	internal Vector3 RotationTo;

	internal Vector3 Velocity = Vector3.zero;

	[Header("Boolean Manager")]
	internal bool IsTranscripted = true;

	[Header("Renders")]
	internal MeshRenderer[] Renders;

	[Header("Vectors")]
	internal Vector3 PositionMe = Vector3.zero;

	internal Vector3 RotationMe = Vector3.zero;

	[Header("Strings")]
	public string IDIInformation = "";

	internal string ItemName = "";

	[Header("Sprites")]
	internal Sprite IconItem;

	[Header("Floating")]
	internal float TimeToCheck = 0.2f;

	[Header("Boolean Manager")]
	internal bool IsAdded;

	[Header("Integer Controller")]
	internal int CountItems;

	internal int IsUsed;

	private void Awake()
	{
		_Controller = UnityEngine.Object.FindObjectOfType<YelbController>();
	}

	private void Start()
	{
		bool flag = false;
		if (GetComponent<NavMeshObstacle>() == null)
		{
			flag = true;
			base.gameObject.AddComponent<NavMeshObstacle>();
		}
		if (flag)
		{
			base.gameObject.GetComponent<NavMeshObstacle>().size = GetComponentInChildren<BoxCollider>().size;
			base.gameObject.GetComponent<NavMeshObstacle>().carving = true;
		}
	}

	private void Update()
	{
		if (MovingGhost == null)
		{
			RotationTo = base.transform.eulerAngles;
			RotationTo.x = 0f;
			RotationTo.z = 0f;
		}
	}

	private void LateUpdate()
	{
		if (TimeToCheck > 0f)
		{
			TimeToCheck -= Time.deltaTime;
		}
		else
		{
			if (!(IconItem != null))
			{
				return;
			}
			if (!IsAdded)
			{
				if (!string.IsNullOrEmpty(IDIInformation) && IDIInformation != "")
				{
					_Controller.AddDataObject(IDIInformation);
				}
				else
				{
					IDIInformation = base.name + "/" + ItemName + "/" + IconItem.name + "/" + IsUsed.ToString() + "/" + CountItems.ToString() + "/" + base.transform.position.ToString() + "/" + base.transform.eulerAngles.ToString();
					_Controller.AddDataObject(IDIInformation);
				}
				if (GetComponent<YelbShelf>() != null)
				{
					for (int i = 0; i < GetComponent<YelbShelf>().Shelfs.Length; i++)
					{
						GetComponent<YelbShelf>().Shelfs[i].LoadShelfData();
					}
				}
				_Controller.SaveDataObject(base.gameObject, IconItem.name, ItemName, CountItems, IDIInformation, base.transform.position, base.transform.eulerAngles, STMode: true);
				IsAdded = true;
			}
			else if ((PositionMe != base.transform.position || RotationMe != base.transform.eulerAngles) && MovingGhost == null)
			{
				_Controller.SaveDataObject(base.gameObject, IconItem.name, ItemName, CountItems, IDIInformation, base.transform.position, base.transform.eulerAngles, STMode: true);
				PositionMe = base.transform.position;
				RotationMe = base.transform.eulerAngles;
			}
		}
	}

	public void SetPositionGhost(Vector3 POS, bool Action)
	{
		Debug.Log("SetPositionGhost");
		if (MovingGhost == null)
		{
			Transform transform = UnityEngine.Object.Instantiate(Interactable).transform;
			transform.position = base.transform.position;
			transform.eulerAngles = RotationTo;
			Renders = transform.GetComponentsInChildren<MeshRenderer>();
			MovingGhost = transform;
			return;
		}
		POS.y = 0.2420732f;
		MovingGhost.gameObject.SetActive(value: true);
		base.gameObject.SetActive(value: false);
		MovingGhost.position = POS;
		MovingGhost.transform.eulerAngles = RotationTo;
		Collider component = MovingGhost.GetComponent<Collider>();
		component.enabled = true;
		if (MovingGhost.GetComponent<BoxCollider>() != null)
		{
			MovingGhost.GetComponent<BoxCollider>().center = new Vector3(MovingGhost.GetComponent<BoxCollider>().center.x, 0f, MovingGhost.GetComponent<BoxCollider>().center.z);
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

	public void DropIt()
	{
		Debug.Log("DropIt");
		if (MovingGhost != null)
		{
			MovingGhost.parent = null;
			base.transform.position = MovingGhost.position;
			base.transform.eulerAngles = MovingGhost.eulerAngles;
			base.gameObject.SetActive(value: true);
			Object.FindObjectOfType<YelbAudioManager>().StartBigBox();
			UnityEngine.Object.Destroy(MovingGhost.gameObject);
		}
	}
}
