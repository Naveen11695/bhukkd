import 'package:avataaar_image/avataaar_image.dart';

Avataaar womenLongHairCurly = Avataaar(
  skin: Skin.pale,
  style: Style.transparent,
  top: Top.longHairCurly(
    accessoriesType: AccessoriesType.Round,
    facialHair: FacialHair.beardMagestic(
      facialHairColor: FacialHairColor.BlondeGolden,
    ),
  ),
);

var menLongHairBun = Avataaar(
  skin: Skin.pale,
  top: Top.longHairBun(
    accessoriesType: AccessoriesType.Blank,
    facialHair: FacialHair.beardLight(),
  ),
  clothes:Clothes.graphicShirt(ClotheColor.Heather, GraphicType.Pizza),
);

var menShortHairDreads = Avataaar(
  skin: Skin.pale,
  top: Top.shortHairDreads01(
    accessoriesType: AccessoriesType.Sunglasses,
    facialHair: FacialHair.beardMedium(),
  ),
  clothes:Clothes.collarSweater(ClotheColor.Black),
);

var menWithTurban = Avataaar(
  skin: Skin.pale,
  style: Style.circle,
  top: Top.turban(
    accessoriesType: AccessoriesType.Sunglasses,
    facialHair: FacialHair.beardMedium(),
  ),
  clothes:Clothes.shirtVNeck(ClotheColor.White),
);

var womenWithShirtCrewNeck1 = Avataaar(
skin: Skin.light,
top: Top.hijab(
accessoriesType: AccessoriesType.Prescription02,
),
clothes:Clothes.shirtCrewNeck(ClotheColor.PastelRed),
);

var womenWithShirtCrewNeck2= Avataaar(
skin: Skin.pale,
top: Top.longHairBob(
accessoriesType: AccessoriesType.Blank,
),
clothes:Clothes.shirtCrewNeck(ClotheColor.PastelYellow),
);

var womenWithLongHairStraightStrand = Avataaar(
  skin: Skin.light,
  top: Top.longHairStraightStrand(
    accessoriesType: AccessoriesType.Blank,
  ),
  clothes:Clothes.shirtScoopNeck(ClotheColor.Red),
);

var menWithShortHairShortWaved = Avataaar(
  skin: Skin.pale,
  top: Top.shortHairShortWaved(
    accessoriesType: AccessoriesType.Blank,
  ),
  clothes:Clothes.hoodie(ClotheColor.Red),
);

var menWithShortHairSides = Avataaar(
  skin: Skin.light,
  top: Top.shortHairSides(
    accessoriesType: AccessoriesType.Blank,
  ),
  clothes:Clothes.shirtVNeck(ClotheColor.Blue03),
);

var menWithShortHairTheCaesar = Avataaar(
  skin: Skin.darkBrown,
  top: Top.shortHairTheCaesar(
    accessoriesType: AccessoriesType.Blank,
  ),
  clothes:Clothes.hoodie(ClotheColor.Gray02),
);

var womenWithShortHairShaggyMullet = Avataaar(
  skin: Skin.pale,
  top: Top.shortHairShaggyMullet(
    accessoriesType: AccessoriesType.Kurt,
  ),
  clothes:Clothes.hoodie(ClotheColor.Gray01),
);

var womenWithLongHairStraight2  = Avataaar(
skin: Skin.pale,
top: Top.longHairStraight2(
accessoriesType: AccessoriesType.Blank,
),
clothes:Clothes.graphicShirt(ClotheColor.Blue01, GraphicType.Diamond),
);

var menWithShortHairShortFlat = Avataaar(
  skin: Skin.brown,
  top: Top.shortHairShortFlat(
    accessoriesType: AccessoriesType.Blank,
  ),
  clothes:Clothes.shirtVNeck(ClotheColor.Blue03),
);

var menWithShortHairShortCurly = Avataaar(
  skin: Skin.light,
  top: Top.shortHairShortCurly(
    accessoriesType: AccessoriesType.Blank,
  ),
  clothes:Clothes.collarSweater(ClotheColor.Blue01),
);

var menWithEyePatch = Avataaar(
  skin: Skin.pale,
  top: Top.eyepatch(
    accessoriesType: AccessoriesType.Blank,
  ),
  clothes:Clothes.graphicShirt(ClotheColor.Black,GraphicType.Skull),
);

var womenWithLongHairNotTooLong = Avataaar(
skin: Skin.pale,
top: Top.longHairNotTooLong(
accessoriesType: AccessoriesType.Blank,
),
clothes:Clothes.shirtCrewNeck(ClotheColor.Heather),
);