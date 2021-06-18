public static class DriftServer
{
    public static class Handle
    {
        public static void EnterVehicle(int fromClient, Packet packet)
        {

        }

        public static void ExitVehicle(int fromClient, Packet packet)
        {

        }

        public static void UpdateCar(int fromClient, Packet packet)
        {

        }
    }

    public static class Send
    {
        public static void UpdateCar(Car car)
        {
            using (var packet = new Packet((int)DriftClient.Packets.updateCar))
            {

            }
        }
        public static void EnterVehicle(int fromClient)
        {
            using (var packet = new Packet((int)DriftClient.Packets.enterVehicle))
            {

            }
        }
    }

    public enum Packets
    {
        offset = 2360,
        updateCar,
        enterVehicle,
        exitVehicle,
    }
}