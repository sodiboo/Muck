
using System.IO;
using System.Xml.Serialization;
using UnityEngine;

// Token: 0x020000B7 RID: 183
public class SaveManager : MonoBehaviour
{
	// Token: 0x17000043 RID: 67
	// (get) Token: 0x060005DC RID: 1500 RVA: 0x0001E2EA File Offset: 0x0001C4EA
	// (set) Token: 0x060005DD RID: 1501 RVA: 0x0001E2F1 File Offset: 0x0001C4F1
	public static SaveManager Instance { get; set; }

	// Token: 0x060005DE RID: 1502 RVA: 0x0001E2F9 File Offset: 0x0001C4F9
	private void Awake()
	{
		if (SaveManager.Instance != null && SaveManager.Instance != this)
		{
		Destroy(base.gameObject);
		}
		else
		{
			SaveManager.Instance = this;
		}
		this.Load();
	}

	// Token: 0x060005DF RID: 1503 RVA: 0x0001E32E File Offset: 0x0001C52E
	public void Save()
	{
		PlayerPrefs.SetString("save", this.Serialize<PlayerSave>(this.state));
	}

	// Token: 0x060005E0 RID: 1504 RVA: 0x0001E346 File Offset: 0x0001C546
	public void Load()
	{
		if (PlayerPrefs.HasKey("save"))
		{
			this.state = this.Deserialize<PlayerSave>(PlayerPrefs.GetString("save"));
			return;
		}
		this.NewSave();
	}

	// Token: 0x060005E1 RID: 1505 RVA: 0x0001E371 File Offset: 0x0001C571
	public void NewSave()
	{
		this.state = new PlayerSave();
		this.Save();
		MonoBehaviour.print("Creating new save file");
	}

	// Token: 0x060005E2 RID: 1506 RVA: 0x0001E390 File Offset: 0x0001C590
	public string Serialize<T>(T toSerialize)
	{
		XmlSerializer xmlSerializer = new XmlSerializer(typeof(T));
		StringWriter stringWriter = new StringWriter();
		xmlSerializer.Serialize(stringWriter, toSerialize);
		return stringWriter.ToString();
	}

	// Token: 0x060005E3 RID: 1507 RVA: 0x0001E3C4 File Offset: 0x0001C5C4
	public T Deserialize<T>(string toDeserialize)
	{
		XmlSerializer xmlSerializer = new XmlSerializer(typeof(T));
		StringReader textReader = new StringReader(toDeserialize);
		return (T)((object)xmlSerializer.Deserialize(textReader));
	}

	// Token: 0x04000561 RID: 1377
	public PlayerSave state;
}
