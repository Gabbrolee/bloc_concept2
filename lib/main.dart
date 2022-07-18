import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing2_boc_cubit/cubit/counter_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
      BlocConsumer<CounterCubit, CounterState>(
        listener: (context, state) {
          if(state.wasIncremented == true){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Incremented'),
                duration: Duration(milliseconds: 6),),);
          } else if(state.wasIncremented == false){
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Decremented"),
                  duration: Duration(milliseconds: 6),)
            );
          }
        },
        builder: (context, state){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('You have pushed the button this many times: '),
                Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          );
        },
    //     child: Center(
    //       child: Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         const Text(
    //           'You have pushed the button this many times:',
    //         ),
    //         BlocBuilder<CounterCubit, CounterState>(
    //             builder: (context, state) {
    //               return Text(
    //                 state.counterValue.toString(),
    //                 style: Theme.of(context).textTheme.headline4,
    //               );
    //             }),
    //       ]),
    // ),
        ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: (){
               BlocProvider.of<CounterCubit>(context).increment();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10,),
          FloatingActionButton(
            onPressed: (){
              BlocProvider.of<CounterCubit>(context).decrement();
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

///Bloc Consumer is use to replace bloclistener and blocbuilder
///in the code, since it encompasses them.
//
// BlocListener<CounterCubit, CounterState>(
// listener: (context, state) {
// if(state.wasIncremented == true){
// Scaffold.of(context).showSnackBar(SnackBar(content: Text('Incremented'), duration: Duration(milliseconds: 6),),);
// } else if(state.wasIncremented == false){
// Scaffold.of(context).showSnackBar(SnackBar(content: Text("Decremented"), duration: Duration(milliseconds: 6),));
// }
// },
// child: Center(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: <Widget>[
// const Text(
// 'You have pushed the button this many times:',
// ),
// BlocBuilder<CounterCubit, CounterState>(
// builder: (context, state) {
// return Text(
// state.counterValue.toString(),
// style: Theme.of(context).textTheme.headline4,
// );
// }),
// ]),
// ),
// ),