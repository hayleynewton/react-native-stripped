package com.symbolscanclient;

import android.view.View;

import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;


public class MapManager extends SimpleViewManager<View> {
  public static final String REACT_CLASS = "MapView";

  @Override
  public String getName() {
    return REACT_CLASS;
  }

  @Override
  protected View createViewInstance(ThemedReactContext reactContext) {
    return new View(reactContext);
  }
}
