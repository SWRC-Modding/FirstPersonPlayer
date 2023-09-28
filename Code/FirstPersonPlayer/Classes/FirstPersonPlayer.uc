class FirstPersonPlayer extends Actor;

const TURN_SPEED = 100.0f; // Couldn't find a rotation equivalent of Pawn::GroundSpeed so this is hardcoded
const MAX_TURN_ANIM_RATE = 2.0f;

var PlayerController Player;
var int LastViewRotationYaw;

function PreBeginPlay(){
	if(Level.NetMode != NM_Standalone)
		Destroy();
	else
		Super.PreBeginPlay();
}

function Tick(float DeltaTime){
	local float Speed;
	local float MaxSpeed;
	local float TurnSpeed;
	local vector PlayerLocation;
	local rotator ViewRotation;
	local Pawn PlayerPawn;
	local Controller C;

	if(Player == None){
		for(C = Level.ControllerList; C != None; C = C.nextController){
			Player = PlayerController(C);

			if(Player != None)
				break;
		}
	}

	bHidden = Player == None || Player.Pawn == None || Player.Pawn.bIncapacitated || Player.IsInState('Briefing') || Player.bBehindView;

	if(bHidden)
		return;

	PlayerPawn = Player.Pawn;
	PlayerLocation = PlayerPawn.Location;
	ViewRotation = PlayerPawn.GetViewRotation();
	ViewRotation.Pitch = 0; // Make the actor stay upright in the world and only rotate it left and right with the camera
	Speed = VSize(PlayerPawn.Velocity);
	TurnSpeed = ViewRotation.Yaw - LastViewRotationYaw;

	if(PlayerPawn.Base != None){
		if(PlayerPawn.bIsCrouched){
			MaxSpeed = PlayerPawn.GroundSpeed * PlayerPawn.CrouchSpeedRatio;
			PlayerLocation.Z += 30.0f;
		}else if(PlayerPawn.bIsWalking){
			MaxSpeed = PlayerPawn.GroundSpeed * PlayerPawn.WalkSpeedRatio;
		}else{
			MaxSpeed = PlayerPawn.GroundSpeed * 0.75f; // Slightly decrease max speed to get a higher anim rate which looks better with the 'WalkForward' anim
																								 // (Can't use 'RunFoward' because it does not look good in first person)
		}

		if(Speed <= MaxSpeed * 0.05f){ // Small threshold so very little movement does not play a walk animation which looks weird
			if(PlayerPawn.bIsCrouched){
				if(TurnSpeed > 0)
					LoopAnim('CrouchTurnRight', 'None', FMin(TurnSpeed / TURN_SPEED, MAX_TURN_ANIM_RATE));
				else if(TurnSpeed < 0)
					LoopAnim('CrouchTurnLeft', 'None', FMin(-TurnSpeed / TURN_SPEED, MAX_TURN_ANIM_RATE));
				else
					LoopAnim('CrouchBreathe');
			}else{
				if(TurnSpeed > 0)
					LoopAnim('TurnRight', 'None', FMin(TurnSpeed / TURN_SPEED, MAX_TURN_ANIM_RATE));
				else if(TurnSpeed < 0)
					LoopAnim('TurnLeft', 'None', FMin(-TurnSpeed / TURN_SPEED, MAX_TURN_ANIM_RATE));
				else
					LoopAnim('ActionBreathe');
			}
		}else{
			if(PlayerPawn.bIsCrouched)
				LoopAnim('CrouchForward', 'None', Speed / MaxSpeed);
			else
				LoopAnim('WalkForward', 'None', Speed / MaxSpeed);
		}
	}else{
		PlayerLocation.Z -= 15.0f;
		LoopAnim('FallBreathe');
	}

	SetLocation(PlayerLocation);
	SetRotation(ViewRotation);

	LastViewRotationYaw = ViewRotation.Yaw;
}

defaultproperties
{
	DrawType=DT_Mesh
	Mesh=SkeletalMesh'FirstPersonPlayerAnim.FirstPersonPlayer'
}
