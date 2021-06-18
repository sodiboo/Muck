using UnityEngine;
using UnityEngine.Scripting;

public class CarInteract : MonoBehaviour, Interactable
{
    Car car;

    private void Awake()
    {
        car = GetComponentInParent<Car>();
    }

    public void Interact() {
        if (!car.inUse) {
            MoveCamera.Instance.state = MoveCamera.CameraState.Car;
			PlayerMovement.Instance.GetPlayerCollider().enabled = false;
			PlayerMovement.Instance.GetRb().isKinematic = true;
            Hotbar.Instance.gameObject.SetActive(false);
            OtherInput.Instance.currentCar = car;
            car.inUse = true;
        }
    }


    public void LocalExecute() { }


    public void AllExecute() { }


    public void ServerExecute(int fromClient = -1) { }


    public void RemoveObject() { }


    public string GetName() {
        if (!car.inUse) return "";
        return "Enter Vehicle";
    }


    public bool IsStarted() => false;
}