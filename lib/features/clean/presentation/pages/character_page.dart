import 'package:clean_architecture/features/clean/presentation/bloc/clean_bloc.dart';
import 'package:clean_architecture/features/clean/presentation/widgets/character_controls.dart';
import 'package:clean_architecture/features/clean/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class CharacterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Rick And Morty Characters'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<CleanBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<CleanBloc>(),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              // Top half
              BlocBuilder<CleanBloc, CleanState>(
                // ignore: missing_return
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(
                      message: 'Start searching',
                    );
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    print(state.character);
                    return CharacterDisplay(
                      character: state.character,
                    );
                  } else if (state is Error) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  }
                  // We're going to also check for the other states
                },
              ),
              /*Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Placeholder(),
              ),*/
              SizedBox(height: 20),
              CharacterControls(),
            ],
          ),
        )));
  }
}
