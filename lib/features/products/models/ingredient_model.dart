import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/utils/constants/enums.dart';

class IngredientModel {
  final String id;
  final Ingredients name;

  IngredientModel({
    required this.id,
    required this.name,
  });

  String get nameText {
    switch (name) {
      case Ingredients.aloeBarbadensisLeafExtract:
        return "Aloe Barbadensis Leaf Extract";
      case Ingredients.aloeBarbadensisLeafJuice:
        return "Aloe Barbadensis Leaf Juice";
      case Ingredients.aristoteliaChilensisFruitExtract:
        return "Aristotelia Chilensis Fruit Extract";
      case Ingredients.arganiaSpinosaKeralOil:
        return "Argania Spinosa Keral Oil";
      case Ingredients.arginine:
        return "Arginine";
      case Ingredients.ascorbicAcid:
        return "Ascorbic Acid";
      case Ingredients.avobenzone:
        return "Avobenzone";
      case Ingredients.benzoylPeroxide:
        return "Benzoyl Peroxide";
      case Ingredients.bentonite:
        return "Bentonite";
      case Ingredients.camelliaSinensisExtract:
        return "Camellia Sinensis Extract";
      case Ingredients.ceramides:
        return "Ceramides";
      case Ingredients.charcoalPowder:
        return "Charcoal Powder";
      case Ingredients.cholecalciferol:
        return "Cholecalciferol";
      case Ingredients.cocoaButter:
        return "Cocoa Butter";
      case Ingredients.collagen:
        return "Collagen";
      case Ingredients.cocosNuciferaOil:
        return "Cocos Nucifera Oil";
      case Ingredients.cocosNuciferaWater:
        return "Cocos Nucifera Water";
      case Ingredients.cyanocobalamin:
        return "Cyanocobalamin";
      case Ingredients.dimethicone:
        return "Dimethicone";
      case Ingredients.ergothioneine:
        return "Ergothioneine";
      case Ingredients.ferulicAcid:
        return "Ferulic Acid";
      case Ingredients.glycerine:
        return "Glycerine";
      case Ingredients.glycerin:
        return "Glycerin";
      case Ingredients.glycineSojaOil:
        return "Glycine Soja Oil";
      case Ingredients.helianthusAnnuusSeedOil:
        return "Helianthus Annuus Seed Oil";
      case Ingredients.hippophaeRhamnoidesSeedOil:
        return "Hippophae Rhamnoides Seed Oil";
      case Ingredients.homosalate:
        return "Homosalate";
      case Ingredients.honey:
        return "Honey";
      case Ingredients.hydratedSilica:
        return "Hydrated Silica";
      case Ingredients.hydrogenatedRicinusCommunisOil:
        return "Hydrogenated Ricinus Communis Oil";
      case Ingredients.hydroxytyrosol:
        return "Hydroxytyrosol";
      case Ingredients.jojobaOil:
        return "Jojoba Oil";
      case Ingredients.kaolin:
        return "Kaolin";
      case Ingredients.ketoconazole:
        return "Ketoconazole";
      case Ingredients.lacticAcid:
        return "Lactic Acid";
      case Ingredients.lactobacillusFerment:
        return "Lactobacillus Ferment";
      case Ingredients.matricariaChamomillaFlowerExtract:
        return "Matricaria Chamomilla Flower Extract";
      case Ingredients.melaleucaAlternifoliaExtract:
        return "Melaleuca Alternifolia Extract";
      case Ingredients.melaleucaAlternifoliaOil:
        return "Melaleuca Alternifolia Oil";
      case Ingredients.menthaPiperitaExtract:
        return "Mentha Piperita Extract";
      case Ingredients.myristylMyristate:
        return "Myristyl Myristate";
      case Ingredients.niacinamide:
        return "Niacinamide";
      case Ingredients.octisalate:
        return "Octisalate";
      case Ingredients.octocrylene:
        return "Octocrylene";
      case Ingredients.panthenol:
        return "Panthenol";
      case Ingredients.perseaGratissimaOil:
        return "Persea Gratissima Oil";
      case Ingredients.phyticAcid:
        return "Phytic Acid";
      case Ingredients.prunusAmygdalusDulcisOil:
        return "Prunus Amygdalus Dulcis Oil";
      case Ingredients.pyrithioneZinc:
        return "Pyrithione Zinc";
      case Ingredients.resveratrol:
        return "Resveratrol";
      case Ingredients.retinol:
        return "Retinol";
      case Ingredients.ricinusCommunisSeedOil:
        return "Ricinus Communis Seed Oil";
      case Ingredients.rosaCaninaExtract:
        return "Rosa Canina Extract";
      case Ingredients.rosaCaninaOil:
        return "Rosa Canina Oil";
      case Ingredients.salicylicAcid:
        return "Salicylic Acid";
      case Ingredients.shOligopeptide78:
        return "Sh-Oligopeptide-78";
      case Ingredients.sheaButter:
        return "Shea Butter";
      case Ingredients.silkProteins:
        return "Silk Proteins";
      case Ingredients.simmondsiaChinensisSeedOil:
        return "Simmondsia Chinensis Seed Oil";
      case Ingredients.sodiumChloride:
        return "Sodium Chloride";
      case Ingredients.squalane:
        return "Squalane";
      case Ingredients.squalene:
        return "Squalene";
      case Ingredients.stearicAcid:
        return "Stearic Acid";
      case Ingredients.tartaricAcid:
        return "Tartaric Acid";
      case Ingredients.tetrahexyldecylAscorbate:
        return "Tetrahexyldecyl Ascorbate";
      case Ingredients.thermalWater:
        return "Thermal Water";
      case Ingredients.titaniumDioxide:
        return "Titanium Dioxide";
      case Ingredients.tocopherol:
        return "Tocopherol";
      case Ingredients.ubiquinone:
        return "Ubiquinone";
      case Ingredients.volcanicAsh:
        return "Volcanic Ash";
      case Ingredients.vitisViniferaFruitWater:
        return "Vitis Vinifera Fruit Water";
      case Ingredients.vitisViniferaSeedOil:
        return "Vitis Vinifera Seed Oil";
      case Ingredients.witchHazelExtract:
        return "Witch Hazel Extract";
      case Ingredients.zingiberOfficinaleRootExtract:
        return "Zingiber Officinale Root Extract";
      case Ingredients.zinc:
        return "Zinc";
      case Ingredients.zincOxide:
        return "Zinc Oxide";
      default:
        return "";
    }
  }

  /// Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'ingreidentId': id,
      'ingreidentName': name.toString(),
    };
  }

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      id: json['ingreidentId'],
      name: json['ingreidentName'] as Ingredients
    );
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory IngredientModel.fromSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;

    // Map JSON Record to the Model
    return IngredientModel(
      id: document.id,
      name: Ingredients.values.firstWhere((e) => e.toString() == data['ingreidentName']),
    );
  }
}
