 // Import React and ReactDOM
 import React, { version }  from 'react';
 import ReactDOM from 'react-dom/client';
 // Import GraphiQL and the Explorer plugin
 import { GraphiQL } from 'graphiql';
 import { createGraphiQLFetcher } from '@graphiql/toolkit';
 import { explorerPlugin } from '@graphiql/plugin-explorer';
 
 const url = new URL(window.location.href);
 console.log('React version:', version);

 const fetcher = createGraphiQLFetcher({
   url: url.searchParams.get('url') ?? window.__URL__,
 });
 const explorer = explorerPlugin();

 function App() {
   return React.createElement(GraphiQL, {
     fetcher,
     plugins: [explorer],
   });
 }

 const container = document.getElementById('graphiql');
 const root = ReactDOM.createRoot(container);
 root.render(React.createElement(App));