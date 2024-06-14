import { EGDocScanner } from 'eg-doc-scanner';

window.testEcho = () => {
  const inputValue = document.getElementById('echoInput').value;
  EGDocScanner.echo({ value: inputValue });
};
