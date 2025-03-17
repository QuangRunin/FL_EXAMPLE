import 'package:example/pages/splash/sprung.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class SentenceBuildingGame extends StatefulWidget {
  const SentenceBuildingGame({super.key});

  @override
  SentenceBuildingGameState createState() => SentenceBuildingGameState();
}

class SentenceBuildingGameState extends State<SentenceBuildingGame> {
  List<String> words = [
    'Flyer',
    'Chat',
    'has',
    'the',
    'contributor',
    'covenant',
    'as',
    'its',
    'code',
    'of',
    'conduct'
  ];
  final List<int> _sentenceOrder = [];
  final List<Offset> _wordPositions = [];
  final List<Offset> _wordPositionsClone = [];
  List<Offset> _sentencePositions = [];
  final double _spaceOffset = 30.0;
  final double _leftMargin = 16.0;
  final double _rightMargin = 32.0;

  @override
  void initState() {
    super.initState();
    setupGame();
  }

  void setupGame() {
    words.shuffle(Random());
    initialWordsFrame();
  }

  void initialWordsFrame() {
    _wordPositions.clear();
    final double maxWidth = 384.0 - _leftMargin - _rightMargin;
    double yOffset = 300.0;
    double lineHeight = 55.0;
    List<String> currentLine = [];
    double lineWidth = 0.0;

    for (int i = 0; i < words.length; i++) {
      double wordWidth = calculateTextWidth(words[i]);
      double addedWidth =
          wordWidth + (currentLine.isNotEmpty ? _spaceOffset : 0);

      if (lineWidth + addedWidth <= maxWidth) {
        currentLine.add(words[i]);
        lineWidth += addedWidth;
      } else {
        _addCenteredLine(currentLine, lineWidth - _spaceOffset, yOffset);
        currentLine = [words[i]];
        lineWidth = wordWidth;
        yOffset += lineHeight;
      }
    }

    if (currentLine.isNotEmpty) {
      _addCenteredLine(currentLine, lineWidth - _spaceOffset, yOffset);
    }

    _sentencePositions = List.generate(words.length, (_) => Offset(0, 150.0));
  }

  void _addCenteredLine(
      List<String> lineWords, double lineWidth, double yOffset) {
    final double totalWidth = 384.0 - _leftMargin - _rightMargin;
    double xOffset = _leftMargin +
        ((totalWidth - _leftMargin - _rightMargin - lineWidth) / 2);

    for (String word in lineWords) {
      _wordPositions.add(Offset(xOffset, yOffset));
      _wordPositionsClone.add(Offset(xOffset, yOffset));
      xOffset += calculateTextWidth(word) + _spaceOffset;
    }
  }

  double calculateTextWidth(String text, {double fontSize = 16.0}) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: TextStyle(fontSize: fontSize)),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }

  void _moveWord(int index) {
    setState(() {
      _sentenceOrder.contains(index)
          ? _sentenceOrder.remove(index)
          : _sentenceOrder.add(index);
      _updateSentencePositions();
    });
  }

  void _updateSentencePositions() {
    double left = _leftMargin;
    double top = 100.0;
    double maxWidth =
        MediaQuery.of(context).size.width - _leftMargin - _rightMargin;

    for (int index in _sentenceOrder) {
      double wordWidth = calculateTextWidth(words[index]);
      if (left + wordWidth > maxWidth + _leftMargin) {
        left = _leftMargin;
        top += 55.0;
      }
      _sentencePositions[index] = Offset(left, top);
      left += wordWidth + _spaceOffset;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 120,
          left: 20,
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 40,
            height: 175,
            child: ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.only(bottom: 10, top: index == 0 ? 35 : 45),
                    child: Divider(
                      height: 0,
                      thickness: 2,
                      endIndent: 0,
                      indent: 0,
                      color: Colors.grey.withValues(alpha: 0.3),
                    ),
                  );
                }),
          ),
        ),
        ...List.generate(words.length, (index) {
          Offset position = _wordPositionsClone[index];
          return Positioned(
            key: ValueKey('wordD$index'),
            left: position.dx,
            top: position.dy,
            child: Card(
              elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xFF999999),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(words[index],
                    style: TextStyle(fontSize: 16, color: Colors.transparent)),
              ),
            ),
          );
        }),
        ...List.generate(words.length, (index) {
          bool isInSentence = _sentenceOrder.contains(index);
          Offset position =
              isInSentence ? _sentencePositions[index] : _wordPositions[index];
          return AnimatedPositioned(
            key: ValueKey('word$index'),
            duration: Duration(milliseconds: 300),
            curve: Sprung.custom(damping: 200),
            left: position.dx,
            top: position.dy,
            child: GestureDetector(
              onTap: () => _moveWord(index),
              child: Card(
                elevation: 2,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text(words[index], style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
