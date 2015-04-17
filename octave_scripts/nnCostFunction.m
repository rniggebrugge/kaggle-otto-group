function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%


%%%% PART 1

% z1 = [ones(m,1) X] * Theta1';
% a2 = sigmoid(z1);
% a2 = [ones(m,1) a2];
% z2 = a2 * Theta2';

% a3 = sigmoid(z2);

% temp1 = log(a3);
% temp2 = log(1-a3);



% Y0 = eye(num_labels)(y,:);
% Y1 = ones(size(y)) - Y0;

% for i=1:m;
% 	J = J - temp1(i,y(i)) - Y1(i,:)*temp2(i,:)';  
% endfor;


% % J = -sum(temp1'*Y0) - sum(temp2'*Y1);

% J = J/m;

% temp1 = Theta1(:,[2:end]);
% temp1 = temp1.*temp1;
% temp1 = temp1(:);

% temp2 = Theta2(:,[2:end]);
% temp2 = temp2.*temp2;
% temp2 = temp2(:);

% J = J + lambda/(2*m)*(sum(temp1)+sum(temp2));

% % -------------------------------------------------------------

% %%% PART 2

% for i=1:m;
% 	a1 = X(i,:)';
% 	a1=[1; a1];
% 	z2=Theta1*a1;
% 	a2=sigmoid(z2);
% 	a2=[1 ; a2];
% 	z3=Theta2*a2;
% 	a3=sigmoid(z3);

% 	d3 = a3;
% 	d3(y(i))--;
% 	d2 = Theta2'*d3;
% 	d2 = d2(2:end).*sigmoidGradient(z2);
% 	Theta2_grad = Theta2_grad + d3*a2';
% 	Theta1_grad = Theta1_grad + d2*a1';
% endfor

% Theta1_grad = Theta1_grad / m;
% Theta2_grad = Theta2_grad / m;

% Added1 = Theta1 * lambda/m;
% Added1(:,1) = 0;
% Added2 = Theta2 * lambda/m;
% Added2(:,1) = 0;

% Theta1_grad = Theta1_grad + Added1;
% Theta2_grad = Theta2_grad + Added2;

%% THANKS A MILLION:
%% http://swizec.com/blog/i-suck-at-implementing-neural-networks-in-octave/swizec/2929

z = [ones(m,1) X] * Theta1';
h = sigmoid(z);
% assert(all(size(h) == [m,hidden_layer_size]));
o = sigmoid([ones(m,1) h] * Theta2');
% assert(all(size(o) == [m,num_labels]));

y2 = eye(num_labels)(y,:);

J = mean(sum(-y2 .* log(o) - (1 - y2) .* (log(1 - o)),2)) + lambda/(2*m) * (sum(sum(Theta1(:,2:end).^2)) + sum(sum(Theta2(:,2:end).^2)));

delta3 = o - y2;
delta2 = delta3 * Theta2(:,2:end) .* sigmoidGradient(z);
% assert(all(size(delta2) == size(h)));

Theta1_grad = (delta2' * [ones(m,1) X]) /m;
% assert(all(size(Theta1_grad) ==size(Theta1) ));

Theta2_grad = (delta3' * [ones(m,1) h]) /m;
% assert(all(size(Theta2_grad) ==size(Theta2) ));

Theta1_grad(:,2:end) = Theta1_grad(:,2:end) + lambda/m * Theta1(:,2:end);
Theta2_grad(:,2:end) = Theta2_grad(:,2:end) + lambda/m * Theta2(:,2:end);

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
