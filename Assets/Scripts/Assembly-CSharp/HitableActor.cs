public class HitableActor : Hitable
{
	public enum ActorType
	{
		Player = 0,
		Enemy = 1,
	}

	public ActorType actorType;
}
