import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/dnd.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 50.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.deepPurple, // Border color
              width: 2.0, // Border width
            ),
            color: Colors.white70,
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(children: <Widget>[
              Text(
                'Lorem ipsum',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...\n\n",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              SizedBox(height: 10),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vel est justo. Ut tincidunt arcu non elementum sollicitudin. Donec ut turpis commodo, vulputate lorem mattis, vulputate purus. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Morbi tristique nec sem eu ultrices. Vivamus auctor vehicula dui sed facilisis. In efficitur eu nulla ac tempus. Praesent non sapien feugiat, congue erat eget, tristique lectus. \n\n"
                "Quisque eget efficitur risus. Duis tincidunt, dolor quis tincidunt lacinia, augue ipsum faucibus purus, vitae consectetur dolor est sit amet lacus. Phasellus vel dictum mi. Vivamus tristique orci velit, ut molestie massa mollis sit amet. Ut varius nunc erat, ultrices suscipit arcu volutpat a. Nam ac ex ex. Nullam et vulputate nunc, sed elementum est. Aenean auctor urna odio, in semper tellus scelerisque in. Aliquam vitae laoreet nisl. Nullam tempus, urna eu vulputate varius, metus lacus ultricies elit, ut scelerisque ligula ipsum non magna. Praesent commodo purus tellus, sit amet elementum odio elementum posuere. Aliquam vel consequat urna, vel sagittis velit. Etiam laoreet elit sit amet massa ultrices convallis. Etiam non euismod dui. \n\n"
                "Sed dapibus eros sed tristique fermentum. Cras dapibus auctor nunc ac congue. Curabitur quis sodales magna. Maecenas lorem eros, tincidunt sed elit vitae, porta finibus risus. Aenean cursus erat vel consequat dictum. Cras vestibulum lectus nulla, in malesuada purus blandit eget. Nullam vehicula ac nisl ut lobortis. Mauris elementum, felis posuere consectetur rutrum, ex libero venenatis mauris, congue ullamcorper purus mauris non erat. Pellentesque egestas, sapien eget hendrerit accumsan, nibh ex aliquet lectus, a cursus nibh nisl a ex. Nunc eu vestibulum urna, vel mattis dolor.\n\n"
                "Nunc sagittis efficitur nunc sed aliquam. Proin sit amet eleifend sapien. Sed lorem metus, sodales vel egestas sit amet, iaculis eget elit. Integer vitae interdum massa, vitae condimentum eros. In vel ultricies augue. Proin tincidunt risus eu dolor mattis, et pellentesque sapien porttitor. Sed vel massa justo. Sed magna tellus, tincidunt vitae mollis ac, interdum ac nisl. Suspendisse nulla elit, faucibus non metus eget, vestibulum consectetur urna. Donec tempor nisl vitae fermentum hendrerit. In maximus, turpis consequat congue rhoncus, tellus ante pharetra lorem, a porttitor arcu ipsum in nibh. Vestibulum ultrices massa nisi, a eleifend purus sollicitudin et. Vestibulum lacinia viverra elit, ac finibus justo efficitur et. Donec aliquet maximus ipsum. Pellentesque ullamcorper, mi at pulvinar tincidunt, purus dui scelerisque diam, eget facilisis sapien nisi vitae libero. Nulla sit amet tempor urna.\n\n"
                "Nullam et nibh ac mi condimentum tempor ullamcorper ut arcu. Vivamus turpis massa, viverra sed ligula sit amet, bibendum laoreet elit. Donec ultrices lobortis sollicitudin. Suspendisse sollicitudin laoreet nulla, non pulvinar odio consequat vel. Quisque ultricies sodales eleifend. In metus nisl, aliquam quis hendrerit nec, auctor nec purus. Etiam eget pharetra urna, ut rhoncus mi. Nam dolor justo, maximus euismod suscipit quis, maximus et elit. Nunc dapibus posuere sapien, ac consectetur ex euismod interdum. Fusce vel quam in ante maximus porta a vel ipsum. Vestibulum dignissim quam convallis turpis varius, ut tristique sapien laoreet. Sed velit arcu, porta in laoreet id, aliquet ut nulla. Aliquam sit amet viverra lorem. Nulla vestibulum enim in sem malesuada, ac sagittis sapien molestie. Etiam auctor orci hendrerit elementum congue. Integer nec sapien condimentum, interdum erat eget, tincidunt nibh.\n\n",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10),
            ]),
          ),
        ),
      ),
    );
  }
}
