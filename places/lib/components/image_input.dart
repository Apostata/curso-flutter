
import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({ Key? key }) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border.all( width: 1, color: Colors.grey)
            ),
            alignment: Alignment.center,
            child: const Text('Nenhuma imagem...'),
          ),
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: SizedBox(
            height: 100,
            child: TextButton(
              onPressed: ()=>{},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.only( right: 10),
                    child: Icon(
                      Icons.camera, 
                      // color: Colors.black,
                    ),
                  ),
                  Text('Tirar foto', 
                    // style: TextStyle(color: Colors.black),
                  )
                ],
              )
            ),
          ),
        ),
      ],
    );
  }
}