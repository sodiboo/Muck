using System;

// Token: 0x0200008E RID: 142
public interface Interactable
{
	// Token: 0x06000327 RID: 807
	void Interact();

	// Token: 0x06000328 RID: 808
	void LocalExecute();

	// Token: 0x06000329 RID: 809
	void AllExecute();

	// Token: 0x0600032A RID: 810
	void ServerExecute(int fromClient = -1);

	// Token: 0x0600032B RID: 811
	void RemoveObject();

	// Token: 0x0600032C RID: 812
	string GetName();

	// Token: 0x0600032D RID: 813
	bool IsStarted();
}
