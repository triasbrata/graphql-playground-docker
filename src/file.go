package main

import "embed"

//go:embed index.tmpl
var IndexFile embed.FS

//go:embed static/*
var StaticFolder embed.FS
