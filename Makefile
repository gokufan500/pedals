CXX = g++
CXXFLAGS = -std=c++20 -Wall -O2 -Iinclude -Iinclude/imgui
LDFLAGS = -lportaudio -lglfw -lGL -ldl -lpthread -lX11 -lXxf86vm -lXrandr -lXi -lm

# Detect platform
ifeq ($(OS),Windows_NT)
    LDFLAGS += -lopengl32 -lgdi32
    RM = del
else
    RM = rm -f
endif

IMGUI_SRC = $(wildcard src/imgui/*.cpp)

SRCS = $(wildcard *.cpp)
TARGET = pedal

# Object files
OBJS = $(SRCS:.cpp=.o) $(IMGUI_SRC:.cpp=.o)

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) -g $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

# Pattern rule for compiling .cpp to .o
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	$(RM) $(TARGET) $(OBJS)
