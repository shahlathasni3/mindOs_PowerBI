import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mindos_2/ChatPage.dart';
import 'package:mindos_2/contWithGoogle.dart';
import 'package:mindos_2/helpers/dialogues.dart';
import 'package:mindos_2/models/ChatUser.dart';
import 'api/apis.dart';

class profileScreen extends StatefulWidget {


  final ChatUser user;

  const profileScreen({super.key,required this.user});

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {

  final formKey = GlobalKey<FormState>();

  String? images;

  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;



    return Scaffold(
      appBar: AppBar(
        leading: InkWell(onTap : (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> ChatPage()));
        },child: const Icon(Icons.arrow_back)),
        title: Text("Profile Screen",style: TextStyle(
          color: Colors.black, // Text color
          fontSize: 21,
          fontWeight: FontWeight.w500,// Font size
        ),),

      ),

    // Floating button to add new user
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 15, bottom: 15),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.blue.shade400,
          onPressed: () async {
            // Show confirmation dialog before signing out
            bool? confirm = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
            return AlertDialog(
                title: Text('Logout'),
                content: Text('Are you sure you want to log out?'),
                actions: <Widget>[
                TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancel'),
                ),
                TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Logout'),
                ),
            ],
        );
      },
    );

      // If the user confirms logout
      if (confirm == true) {
         Dialogues.showProgressBar(context);
        // Sign out from the app
        await APIs.auth.signOut().then((value) async {
        await GoogleSignIn().signOut().then((value) {
        // Hiding progress dialogue
        Navigator.pop(context);
        // Navigate to the login screen
        Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => contWithGoogle()));
        });
        });
      }
    },
        icon: const Icon(Icons.logout, color: Colors.white),
        label: Text('Logout', style: TextStyle(color: Colors.white)),
      ),
    ),

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
         children: [
           SizedBox(width: width,height: height*.03,),
           // user profile picture
           Center(
             child: Stack(
               children: [
                 ClipRRect(
                   borderRadius: BorderRadius.circular(70),
                   child: CachedNetworkImage(
                     imageUrl: widget.user.image,
                     errorWidget: (context, url, error) => CircleAvatar(child: Icon(CupertinoIcons.person),),
                   ),
                 ),
                 Positioned(
                     top: 50,
                     left: 35,
                     child: MaterialButton(onPressed: (){
                       showBottomsheet();
                     },elevation: 1,color:Colors.white,child: Icon(Icons.edit,color: Colors.blue,),shape: CircleBorder(),))

               ],
             ),
           ),
           SizedBox(height: height*.03,),
           // user email field
           Text(widget.user.email,style: TextStyle(color: Colors.black54,fontSize: 17),),
           SizedBox(height: height*.05,),
           // user name field
           TextFormField(
             initialValue: widget.user.name,
             onSaved: (val) => APIs.me.name = val ?? '',
             validator: (val) => val != null && val.isNotEmpty ? null: "Required field",
             decoration: InputDecoration(
               prefixIcon: Icon(Icons.person,color: Colors.blue,),
               border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
               hintText: 'eg, happy sign',
               label:Text('Name'),
             ),
           ),

           SizedBox(height: height*.02,),
           TextFormField(
             initialValue: widget.user.about,
             onSaved: (val) => APIs.me.about = val ?? '',
             validator: (val) => val != null && val.isNotEmpty ? null: "Required field",
             decoration: InputDecoration(
               prefixIcon: Icon(Icons.info_outline,color: Colors.blue,),
               border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
               hintText: 'eg, Feeling Happy',
               label:Text('About'),
             ),
           ),
           SizedBox(height: height*.05,),
           // update profile button
           ElevatedButton.icon(
             style: ElevatedButton.styleFrom(shape: StadiumBorder(),minimumSize: Size(width*.5, height*.055)),
             onPressed: (){
               // if(formKey.currentState!.validate()){
               //   formKey.currentState!.save();
               //   APIs.updateUserInfo().then((value){
               //     Dialogues.showSnackbar(context, "Profile updated successfully!");
               //   });
               // }
             },
             icon: Icon(Icons.edit,size: 27,color: Colors.blue,),
             label: Text("Update",style: TextStyle(fontSize: 17,color: Colors.blue)),
           ),
         ],
        ),
      ),
    );
  }
  // bottom sheet for picking a profile picture for user
  void showBottomsheet(){
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
        builder: (_){
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(top:height*.03,bottom: height*.05),
            children: [
              Text('Pick Profile Picture.', textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              // buttons
              SizedBox(height: height*.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // pick from gallery button
                  ElevatedButton(
                      onPressed: () async {
                        // final ImagePicker picker = ImagePicker();
                        // // Pick an image.
                        // final XFile? image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
                        //
                        // if(image != null){
                        //   log('Image path : ${image.path} -- MimeType: ${image.mimeType}');
                        //
                        //   setState(() {
                        //     images = image.path;
                        //   });
                        //   // APIs.updateProfilePicture(File(images!));
                        //   // diding bottom sheet
                        //   Navigator.pop(context);
                        // }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: CircleBorder(), fixedSize: Size(width*.3, height*.15)),
                      child: Image.asset('assets/icons/addImage.png')
                  ),
                  // take picture from camera button
                  ElevatedButton(
                      onPressed: () async {
                        // final ImagePicker picker = ImagePicker();
                        // // Pick an image.
                        // final XFile? image = await picker.pickImage(source: ImageSource.camera,imageQuality: 80);
                        //
                        // if(image != null){
                        //   log('Image path : ${image.path}');
                        //
                        //   setState(() {
                        //     images = image.path;
                        //   });
                        //   // APIs.updateProfilePicture(File(images!));
                        //   // hiding bottom sheet
                        //   Navigator.pop(context);
                        // }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: CircleBorder(), fixedSize: Size(width*.3, height*.15)),
                      child: Image.asset('assets/icons/addCamera.jpg')
                  ),
                ],
              )
            ],
          );
        });

  }
}
