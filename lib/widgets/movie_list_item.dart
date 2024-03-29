import 'package:flutter/material.dart';
class MovieListItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String information;
  final GlobalKey backgroundImageKey=GlobalKey();
  
  MovieListItem({Key? key,required this.imageUrl, required this.name, required this.information}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom:10.0),
      child: AspectRatio(
        aspectRatio: 16/9,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children:[
              Flow(
                delegate : _ParallaxFlowDelegate(scrollable: Scrollable.of(context),listItemContext: context,backgroundImageKey:backgroundImageKey, ),
                children: [Image.asset(imageUrl,
                width : double.infinity,
                key: backgroundImageKey,
                fit: BoxFit.cover,
                ),]
              ),
              Positioned.fill(
                child:DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors:[Colors.transparent,Colors.transparent.withOpacity(0.7),],
                      begin:Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops:[0.6,0.95]//change trans to black
                      ),
                      ),),
                      ),
                      Positioned(
                        left:20,
                        bottom:20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                          Text(name,style: Theme.of(context).textTheme.bodySmall!.copyWith( color:Colors.white,fontWeight: FontWeight.bold)),
                          Text(information,style: Theme.of(context).textTheme.bodySmall!.copyWith( color:Colors.white,fontWeight: FontWeight.bold)),
                        ]),
                      )
            ]),
          ),
        ))
    );
  }
}

class _ParallaxFlowDelegate extends FlowDelegate{

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  _ParallaxFlowDelegate({
    required this.scrollable,required this.listItemContext,required this.backgroundImageKey}
    ): super(repaint: scrollable.position);

BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(width: constraints.maxWidth);
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // TODO: implement paintChildren
    final scrolllabeBox=scrollable.context.findRenderObject() as RenderBox;
    final listItemBox=listItemContext.findRenderObject() as RenderBox;
    final listItemOffset=listItemBox.localToGlobal(
      listItemBox.size.centerLeft(Offset.zero),
      ancestor: scrolllabeBox,
    ) ;

    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction = (listItemOffset.dy/viewportDimension).clamp(0.0,1.0);
  final verticalAlignment = Alignment(0.0,scrollFraction*2-1);
  final backgroundSize = (backgroundImageKey.currentContext!.findRenderObject() as RenderBox).size;
  final listItemSize = context.size;
  final childRect = verticalAlignment.inscribe(backgroundSize,Offset.zero & listItemSize);

  context.paintChild(
    0,
    transform: Transform.translate(offset: Offset(0.0,childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(covariant _ParallaxFlowDelegate oldDelegate) {
    // TODO: implement shouldRepaint
    return scrollable != oldDelegate.scrollable || listItemContext != oldDelegate.listItemContext || backgroundImageKey != oldDelegate.backgroundImageKey;
  }

}