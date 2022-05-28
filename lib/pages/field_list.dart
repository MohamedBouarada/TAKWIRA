import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../models/field_model.dart';
import '../providers/fields.dart';
import '../widgets/owner_field_item.dart';
import '../widgets/app_drawer.dart';
import './field_edit.dart';

class FieldsList extends StatefulWidget {
  static const routeName = '/owner-fields';

  @override
  State<FieldsList> createState() => _FieldsListState();
}

class _FieldsListState extends State<FieldsList> {
  late Future<List<FieldModel>> futureData;
  bool isApiCallProcess = false;
  Future<void> _refreshFields(BuildContext context) async {
    await Provider.of<Fields>(context).fetchAndSetFields();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureData = Fields.getFields();
    
  }

  Widget loadFields() {
    return FutureBuilder<List<FieldModel>>(
      future: futureData,
      builder: (context, snapshot) {
        print(snapshot.hasData);

        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (_, i) => Column(
              children: [
                FieldItem(
                  snapshot.data![i].id,
                  snapshot.data![i].name,
                  snapshot.data![i].adresse,
                  snapshot.data![i].type,
                  snapshot.data![i].isNotAvailable,
                  snapshot.data![i].services,
                  snapshot.data![i].price,
                  snapshot.data![i].period,
                  snapshot.data![i].surface,
                  snapshot.data![i].description,
                  snapshot.data![i].idProprietaire,
                ),
                Divider(),
              ],
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Fields'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditFieldList.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProgressHUD(
        child: loadFields(),
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
      ),
    );
  }
}













// import 'package:flutter/material.dart';
// import '../models/field_model.dart';
// import '../pages/field_item.dart';
// import '../services/api_service.dart';
// import 'package:snippet_coder_utils/ProgressHUD.dart';

// class FieldsList extends StatefulWidget {
//   const FieldsList({Key? key}) : super(key: key);

//   @override
//   _FieldsListState createState() => _FieldsListState();
// }

// class _FieldsListState extends State<FieldsList> {
//   late Future<List<FieldModel>> futureData;
//   // List<FieldModel> Fields = List<FieldModel>.empty(growable: true);
//   bool isApiCallProcess = false;
//   @override
//   void initState() {
//     super.initState();
//     futureData = APIService.getFields();

//     // Fields.add(
//     //   FieldModel(
//     //     id: "1",
//     //     FieldName: "Haldiram",
//     //     FieldImage:
//     //         "https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=85,metadata=none,w=400,h=400/app/images/Fields/full_screen/pro_86973.jpg",
//     //     FieldDescription: "Haldiram Foods",
//     //     FieldPrice: 500,
//     //   ),
//     // );

//     // Fields.add(
//     //   FieldModel(
//     //     id: "1",
//     //     FieldName: "Haldiram",
//     //     FieldImage:
//     //         "https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=85,metadata=none,w=400,h=400/app/images/Fields/full_screen/pro_86973.jpg",
//     //     FieldDescription: "Haldiram Foods",
//     //     FieldPrice: 500,
//     //   ),
//     // );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//       ),
//       backgroundColor: Colors.grey[200],
//       body: ProgressHUD(
//         child: loadFields(),
//         inAsyncCall: isApiCallProcess,
//         opacity: 0.3,
//         key: UniqueKey(),
//       ),
//     );
//   }

//   Widget loadFields() {
//     return FutureBuilder<List<FieldModel>>(
//       future: futureData,
//       builder: (context, snapshot) {
//         //print(snapshot.hasData);
//         print(APIService.getFields().toString());
//         if (snapshot.hasData) {
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (_, index) => Text("${snapshot.data![index].name}"),
//           );
//         }

//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );
//   }

//   Widget FieldList(Fields) {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   onPrimary: Colors.white,
//                   primary: Colors.green,
//                   minimumSize: const Size(88, 36),
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(10),
//                     ),
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.pushNamed(
//                     context,
//                     '/add-Field',
//                   );
//                 },
//                 child: const Text('Add Field'),
//               ),
//               // ListView.builder(
//               //   shrinkWrap: true,
//               //   physics: const ClampingScrollPhysics(),
//               //   scrollDirection: Axis.vertical,
//               //   itemCount: Fields.length,
//               //   itemBuilder: (context, index) {
//               //     return FieldItem(
//               //       model: Fields[index],

//               //     );
//               //   },
//               // ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
