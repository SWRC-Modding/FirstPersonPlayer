class FirstPersonPlayerCommando extends PlayerCommando;

function PostBeginPlay(){
	local FirstPersonPlayer FP;

	Tag = 'PlayerCommando';
	Super.PostBeginPlay();

	foreach AllActors(class'FirstPersonPlayer', FP)
	 break;

	if(FP == None)
		Spawn(class'FirstPersonPlayer');
}


defaultproperties {
     DamageMultipliers(0)=(BoneName="Head",Multiplier=2)
     FinishingMoves(0)=(EnemyClass="TrandoshanSlaverBerserker",Animation="CommandoFinishBerserkFront",DirectionFromEnemy=DIR_Forward,OffsetFromEnemy=(X=175))
     FinishingMoves(1)=(EnemyClass="TrandoshanSlaver",Animation="CommandoFinishSlaverFront",DirectionFromEnemy=DIR_Forward,OffsetFromEnemy=(X=160))
     FinishingMoves(2)=(EnemyClass="GeonosianDrone",Animation="CommandoFinishGeonosianDroneFront",DirectionFromEnemy=DIR_Forward,OffsetFromEnemy=(X=200))
     FinishingMoves(3)=(EnemyClass="GeonosianWarrior",Animation="CommandoFinishGeonosianWarriorFront",DirectionFromEnemy=DIR_Forward,OffsetFromEnemy=(X=230))
     FinishingMoves(4)=(EnemyClass="TrandoshanMerc",Animation="CommandoFinishMercFront",DirectionFromEnemy=DIR_Forward,OffsetFromEnemy=(X=200))
     MeshSets(0)=(Mesh=SkeletalMesh'Clone.CloneCommando',Set=MeshAnimation'Clone.CloneCommandoSPSet')
     Skins(0)=Shader'CloneTextures.CloneTextures.CloneCommando38_Shader'
     Begin Object Class=KarmaParamsSkel Name=KarmaParamsSkel93
         KConvulseSpacing=(Max=2.2)
         KLinearDamping=0.15
         KAngularDamping=0.05
         KBuoyancy=1
         KStartEnabled=True
         KVelDropBelowThreshold=50
         bHighDetailOnly=False
         KFriction=1.5
         KRestitution=0.1
         KImpactThreshold=400
         Name="KarmaParamsSkel93"
     End Object
     KParams=KarmaParamsSkel'FirstPersonPlayer.KarmaParamsSkel93'
}
