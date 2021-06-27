using System;

// Token: 0x0200009C RID: 156
public interface Interactable
{
	// Token: 0x060003C6 RID: 966
	void Interact();

	// Token: 0x060003C7 RID: 967
	void LocalExecute();

	// Token: 0x060003C8 RID: 968
	void AllExecute();

	// Token: 0x060003C9 RID: 969
	void ServerExecute(int fromClient = -1);

	// Token: 0x060003CA RID: 970
	void RemoveObject();

	// Token: 0x060003CB RID: 971
	string GetName();

	// Token: 0x060003CC RID: 972
	bool IsStarted();
}
