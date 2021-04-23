package com.cuong.shop;

import com.github.slugify.Slugify;

public class Utilities {
	public static String seo(String text) {
		return new Slugify().slugify(text);
	}
}
