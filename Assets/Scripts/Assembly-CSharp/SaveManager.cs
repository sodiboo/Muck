using System;
using System.IO;
using System.Xml.Serialization;
using UnityEngine;

// Token: 0x020000F3 RID: 243
public class SaveManager : MonoBehaviour
{
	// Token: 0x1700004C RID: 76
	// (get) Token: 0x0600066F RID: 1647 RVA: 0x000061D5 File Offset: 0x000043D5
	// (set) Token: 0x06000670 RID: 1648 RVA: 0x000061DC File Offset: 0x000043DC
	public static SaveManager Instance { get; set; }

	// Token: 0x06000671 RID: 1649 RVA: 0x000061E4 File Offset: 0x000043E4
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

	// Token: 0x06000672 RID: 1650 RVA: 0x00006219 File Offset: 0x00004419
	public void Save()
	{
		PlayerPrefs.SetString("save", this.Serialize<PlayerSave>(this.state));
	}

	// Token: 0x06000673 RID: 1651 RVA: 0x00006231 File Offset: 0x00004431
	public void Load()
	{
		if (PlayerPrefs.HasKey("save"))
		{
			this.state = this.Deserialize<PlayerSave>(PlayerPrefs.GetString("save"));
			return;
		}
		this.NewSave();
	}

	// Token: 0x06000674 RID: 1652 RVA: 0x0000625C File Offset: 0x0000445C
	public void NewSave()
	{
		this.state = new PlayerSave();
		this.Save();
		MonoBehaviour.print("Creating new save file");
	}

	// Token: 0x06000675 RID: 1653 RVA: 0x00021F2C File Offset: 0x0002012C
	public string Serialize<T>(T toSerialize)
	{
		XmlSerializer xmlSerializer = new XmlSerializer(typeof(T));
		StringWriter stringWriter = new StringWriter();
		xmlSerializer.Serialize(stringWriter, toSerialize);
		return stringWriter.ToString();
	}

	// Token: 0x06000676 RID: 1654 RVA: 0x00021F60 File Offset: 0x00020160
	public T Deserialize<T>(string toDeserialize)
	{
		XmlSerializer xmlSerializer = new XmlSerializer(typeof(T));
		StringReader textReader = new StringReader(toDeserialize);
		return (T)((object)xmlSerializer.Deserialize(textReader));
	}

	// Token: 0x04000665 RID: 1637
	public PlayerSave state;
}
