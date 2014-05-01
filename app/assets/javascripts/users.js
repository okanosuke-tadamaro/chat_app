function webCam() {
	(function(){
		var emotions = ["happy", "sad", "mad", "surprised", "rofl", "confused"];
		var mediaOptions = { audio: false, video: true };
		var video = document.querySelector("#player");
		var canvas = document.querySelector("#canvas");
		var width = 171;
		var height = 128;
		var data;

		if (!navigator.getUserMedia) {
			navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
		}
		if (!navigator.getUserMedia){
			return alert('getUserMedia not supported in this browser.');
		}
		navigator.getUserMedia(mediaOptions, success, function(e) {
			console.log(e);
		});

		function success(stream){
			video.src = window.URL.createObjectURL(stream);
		}

		function createPhoto() {
			if (emotions.length > 0) {
				$.ajax({
					url: '/create_avatar',
		    	method: 'post',
		    	dataType: 'json',
		    	data: {file: data, emotion: emotions.splice(0, 1)[0]}
				}).done(function(data) {
					console.log(data);
					var imageTag = document.createElement('img');
					imageTag.setAttribute('src', data.file);
					imageTag.id = data.emotion;
					document.querySelector('.photo-right').appendChild(imageTag);
					if (emotions.length === 0) {
						document.querySelector('#status').innerHTML = "You're ready to go! click next to proceed!";
						document.querySelector('#photo-area').removeChild(document.querySelector('#startbutton'));
						document.querySelector('#photo-area').removeChild(document.querySelector('#confirm-button'));
						var nextButton = document.createElement('button');
						nextButton.id = 'next-button';
						nextButton.innerHTML = "Next";
						document.querySelector('#photo-area').appendChild(nextButton);
						nextButton.addEventListener('click', function() {
							window.location.href = '/chatrooms';
						});
					} else {
						document.querySelector('#status').innerHTML = 'Make a ' + emotions[0] + ' face!';
					}
				});
			} else {
				alert('done!');
			}
		}

		function takePhoto() {
			$('#confirm-button').remove();
			var confirmButton = document.createElement('button');
	    confirmButton.id = "confirm-button";
	    confirmButton.innerHTML = "Confirm";
	    document.querySelector('.buttons').appendChild(confirmButton);
	    confirmButton.addEventListener('click', createPhoto);

			height = video.videoHeight / (video.videoWidth/width);
      video.setAttribute('width', width);
      video.setAttribute('height', height);
      canvas.setAttribute('width', width);
      canvas.setAttribute('height', height);

	    canvas.getContext('2d').drawImage(video, 0, 0, width, height);
	    data = canvas.toDataURL('image/png');
		}

		document.querySelector('#status').innerHTML = 'Make a happy face!';
		document.querySelector('#startbutton').addEventListener('click', takePhoto);
	})();
}
