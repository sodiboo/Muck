using System;

public interface Interactable
{
	void Interact();

	void LocalExecute();

	void AllExecute();

	void ServerExecute(int fromClient = -1);

	void RemoveObject();

	string GetName();

	bool IsStarted();
}
