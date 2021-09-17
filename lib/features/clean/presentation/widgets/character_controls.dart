import 'package:clean_architecture/features/clean/presentation/bloc/clean_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterControls extends StatefulWidget {
  const CharacterControls({
    Key key,
  }) : super(key: key);

  @override
  _CharacterControlsState createState() => _CharacterControlsState();
}

class _CharacterControlsState extends State<CharacterControls> {
  final controller = TextEditingController();
  String inputStr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input',
          ),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            dispatchCharacterById();
          },
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                child: Text('Search'),
                color: Theme.of(context).accentColor,
                textTheme: ButtonTextTheme.primary,
                onPressed: dispatchCharacterById,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: RaisedButton(
                child: Text('Get all characters'),
                onPressed: dispatchCharacters,
              ),
            ),
          ],
        )
      ],
    );
  }

  void dispatchCharacterById() {
    // Clear and ready for use again
    controller.clear();
    BlocProvider.of<CleanBloc>(context).add(GetCharacterForId(inputStr));
  }

  void dispatchCharacters() {
    // Clear and ready for use again
    controller.clear();
    BlocProvider.of<CleanBloc>(context).add(GetCharactersNoId());
  }
}
