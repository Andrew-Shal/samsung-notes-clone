import 'package:flutter/material.dart';
import '../widgets/notes_list_tile.dart';
import 'package:notes_app/src/blocs/notes_bloc.dart';
import '../blocs/notes_provider.dart';
import '../models/note_model.dart';
import '../widgets/menu_list.dart';

class NotesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotesListState();
}

class NotesListState extends State<NotesList> {
  bool noteItemLongPressed = false;
  int selectedNoteId = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // ignore: todo
  // TODO: will control appbar text opacity
  double _appBarTextOpacity = 1.0;

  @override
  Widget build(BuildContext context) {
    final bloc = NotesProvider.of(context);

    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          leading: Container(),
          expandedHeight: 200.0,
          floating: true,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: buildAppBar(bloc),
            /*background: Image.network(
              "https://images.pexels.com/photos/583846/pexels-photo-583846.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
              fit: BoxFit.cover,
            ),*/
            // collapseMode: CollapseMode.parallax,
          ),
          bottom: (AppBar(
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
            title: Row(children: [
              Opacity(opacity: _appBarTextOpacity, child: Text('All notes')),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
                alignment: Alignment.centerRight,
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
                alignment: Alignment.centerRight,
              )
            ]),
          )),
        ),
        SliverFillRemaining(
          child: Container(
            height: MediaQuery.of(context).size.height - 80,
            child: buildList(bloc),
          ),
          hasScrollBody: false,
        )
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () => print('floating add note button clicked'),
          child: Icon(Icons.add)),
      drawer: Drawer(child: MenuList()),
      bottomNavigationBar: noteItemLongPressed
          ? BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  title: Text('Business'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  title: Text('School'),
                ),
              ],
              currentIndex: 0,
              selectedItemColor: Colors.amber[800],
              onTap: null,
            )
          : Text('not pressed!'),
    );
  }

  Widget buildAppBar(NotesBloc bloc) {
    bloc.fetchNotesCount();
    return StreamBuilder(
        builder: (context, AsyncSnapshot<int> snapshot) {
          if (!snapshot.hasData) return Text('');
          return Container(
            child: Column(
              children: [
                Text(
                  'All notes',
                  textAlign: TextAlign.left,
                ),
                Text(
                  "${snapshot.data} note${snapshot.data <= 1 ? '' : 's'}",
                  style: TextStyle(fontSize: 12.0),
                  textAlign: TextAlign.left,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          );
        },
        stream: bloc.notesCount);
  }

  Widget buildList(NotesBloc bloc) {
    bloc.fetchNotes();
    return StreamBuilder(
        stream: bloc.notes,
        builder: (context, AsyncSnapshot<List<NoteModel>> snapshot) {
          if (!snapshot.hasData) return Center(child: Text('All notes'));

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index) {
              return Scrollbar(
                  child: NotesListTile(
                      noteItem: snapshot.data[index],
                      onNoteItemLongPressed: onNoteItemLongPressed));
            },
          );
        });
  }

  onNoteItemLongPressed(int noteId) {
    setState(() {
      noteItemLongPressed = true;
      selectedNoteId = noteId;
    });
  }
}
